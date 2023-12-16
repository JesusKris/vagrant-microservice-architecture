const express = require("express")
require('dotenv/config')
const setupRoutes = require("./routes.js"); 
const { connectQueue } = require("./receiver.js");


const app = express()
app.use(express.json());

setupRoutes(app)
connectQueue()


app.listen(process.env.EXPRESS_PORT,process.env.BILLING_PRIVATE_NET_IP, () => {
  console.log(`Billing-app listening at http://${process.env.BILLING_PRIVATE_NET_IP}:${process.env.EXPRESS_PORT}`)
})