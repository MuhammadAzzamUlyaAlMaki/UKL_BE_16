import Express from 'express'
import UserRoute from "./router/userRouter"
import ItemRoute from "./router/itemRouter"
import BorrowRoute from './router/borrowRouter'

const app = Express()

app.use(Express.json())

app.use(`/api`, UserRoute)
app.use(`/api`, ItemRoute)
app.use(`/api`, BorrowRoute)

const PORT = process.env.PORT || 3000
app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`)
})