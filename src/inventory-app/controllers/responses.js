class SuccessRes {
    req
    res
    responseType
    detail
    costumData

    constructor(req, res, responseType, detail) {
        this.req = req
        this.res = res
        this.responseType = responseType
        this.detail = detail
        this.costumData = {}
    }

    _getObject() {
        let response = {
            body: {
                code: this.responseType.code,
                type: this.responseType.type,
                detail: this.detail,
                apiVersion: process.env.API_VERSION,
                timestamp: new Date(Date.now()).toISOString(),
                path: this.req.originalUrl
            }
        }



        for (const [key, value] of Object.entries(this.costumData)) {
            response.body[key] = value
        }

        return response
    }

    addCostumData(key, value) {
        this.costumData[key] = value
    }

    send() {
        const responseObj = this._getObject()

        this.res.setHeader('Content-Type', 'application/json');
        this.res.statusMessage = responseObj.body.type
        this.res.status(responseObj.body.code).json(responseObj)
    }
}


class ErrorRes {
    req
    res
    responseType
    detail

    constructor(req, res, responseType, detail) {
        this.req = req
        this.res = res
        this.responseType = responseType
        this.detail = detail
    }

    _getObject() {
        return {
            error: {
                code: this.responseType.code,
                type: this.responseType.type,
                detail: this.detail,
                apiVersion: process.env.API_VERSION,
                timestamp: new Date(Date.now()).toISOString(),
                path: this.req.originalUrl
            }
        }
    }

    send() {
        const responseObj = this._getObject()

        this.res.statusMessage = responseObj.error.type
        this.res.status(responseObj.error.code).json(responseObj)
    }
}


const ResponseTypes = {
    Success200: { code: 200, type: "SUCCESS" },
    BadRequest400: { code: 400, type: "BAD_REQUEST" },
    NotAllowedMethod405: { code: 405, type: "NOT_ALLOWED_METHOD" },
    InternalServerError500: { code: 500, type: "INTERNAL_SERVER_ERROR" }
}

module.exports = { SuccessRes, ErrorRes, ResponseTypes }


