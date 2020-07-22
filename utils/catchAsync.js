module.exports = (fn) => {
  return (req, res, next) => {
    fn(req, res, next).catch(next); //err => next(err) same as next
  };
};