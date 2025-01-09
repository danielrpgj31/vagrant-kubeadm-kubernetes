
function getfactor(req, res) {
  
  // Parse the handler input
  const name = "Dev Alone."
  const response = `Hello from service-c ${name}!`
  res.send(response)

}
module.exports = getfactor
