const router = require('express').Router();

const PhapDienController = require("../controller/phapdien.controller");
    router.get('/ChuDe', PhapDienController.getChuDe);
    router.get('/CacDieu', PhapDienController.getAllDieu);
    router.post('/DeMuc', PhapDienController.getDeMuc);
    router.post('/CacChuong', PhapDienController.getChuong);
    router.post('/CacDieu', PhapDienController.getDieu);
    router.post('/ChiTiet', PhapDienController.getChiTiet);
module.exports = router;