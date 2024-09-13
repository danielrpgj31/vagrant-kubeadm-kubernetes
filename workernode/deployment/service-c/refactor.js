
function refactor(req, res) {
  
  // Parse the handler input
  const name = "Dev Alone."
  const response = `Hello from service-b ${name}!`
  res.send(response)

}
module.exports = refactor
