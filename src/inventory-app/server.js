const express = require("express")
require('dotenv/config')
const setupRoutes = require("./routes.js") 


const app = express()
app.use(express.json());

setupRoutes(app)



app.listen(process.env.EXPRESS_PORT,process.env.INVENTORY_PRIVATE_NET_IP, () => {
  console.log(`Inventory-app listening at http://${process.env.INVENTORY_PRIVATE_NET_IP}:${process.env.EXPRESS_PORT}`)
})