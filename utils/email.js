const nodemailer = require('nodemailer');
const sgMail = require('@sendgrid/mail');
const mailgun = require('mailgun-js')({
  apiKey: process.env.MAILGUN_API_KEY,
  domain: process.env.MAILGUN_DOMAIN,
});
const pug = require('pug');
const htmlToText = require('html-to-text');

module.exports = class Email {
  constructor(user, url) {
    this.to = user.email;
    this.firstName = user.name.split(' ')[0];
    this.url = url;
    this.from = `MyRecipeBoxTeam <${process.env.EMAIL_FROM}>`;
  }

  newTransport() {
    if (process.env.NODE_ENV === 'development') {
      // MailTrap
      return nodemailer.createTransport({
        host: process.env.EMAIL_HOST,
        port: process.env.EMAIL_PORT,
        auth: {
          user: process.env.EMAIL_USERNAME,
          pass: process.env.EMAIL_PASSWORD,
        },
      });
    }
  }

  async send(template, subject) {
    // 1)Render HTML based on a pug template
    const html = pug.renderFile(
      `${__dirname}/../views/emails/${template}.pug`,
      {
        firstName: this.firstName,
        url: this.url,
        subject,
      }
    );
    // 2) Define email options

    const mailOptions = {
      to: this.to,
      from: this.from,
      subject,
      html,
      text: htmlToText.fromString(html),
    };

    // 3) Actually send the email

    if (process.env.NODE_ENV === 'production') {
      // sgMail.setApiKey(process.env.SENDGRID_API_KEY);
      //   try {
      //     await sgMail.send(mailOptions);
      //   } catch (error) {
      //     console.log(error);
      //   }

      try {
        await mailgun.messages().send(mailOptions);
      } catch (error) {
        console.log(error);
      }
    } else if (process.env.NODE_ENV === 'development') {
      await this.newTransport().sendMail(mailOptions);
    }
  }

  async sendVerificationEmail() {
    await this.send(
      'emailVerification',
      'Your email verification token. (Valid for only 10 min)'
    );
  }

  async sendPasswordReset() {
    await this.send(
      'passwordReset',
      'Your password reset token. (Valid for only 10 min)'
    );
  }
};
