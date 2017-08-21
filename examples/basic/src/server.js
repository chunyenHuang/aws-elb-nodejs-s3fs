const app = require('express')();
const port = process.env.PORT || 8080;
app.get('/', (req, res)=>{
    res.send({
        message: 'Debian NodeJS s3fs'
    });
});
app.listen(port);