var util = require('../../../utils/util.js');
var api = require('../../../config/api.js');

Page({
  data: {
    orderId: 0,
    order: {},
    orderGoods: [],
    aftersale: {},
    statusColumns: ['미적용', '적용됨, 검토 대기 중', '승인 됨, 환불 대기 중', '환불 성공', '승인 실패, 거부 됨'],
    typeColumns: ['미수령 상품 환불', '미반품 상품 환불', '반품 환불'],
    fileList: []
  },
  onLoad: function (options) {
    // 页面初始化 options为页面跳转所带来的参数
    this.setData({
      orderId: options.id
    });
    this.getAftersaleDetail();
  },
  getAftersaleDetail: function () {
    wx.showLoading({
      title: '로딩 중',
    });

    setTimeout(function () {
      wx.hideLoading()
    }, 2000);

    let that = this;
    util.request(api.AftersaleDetail, {
      orderId: that.data.orderId
    }).then(function (res) {
      if (res.errno === 0) {
        let _fileList = []
        res.data.aftersale.pictures.forEach(function (v) {
          _fileList.push({
            url: v
          })
        });

        that.setData({
          order: res.data.order,
          orderGoods: res.data.orderGoods,
          aftersale: res.data.aftersale,
          fileList: _fileList
        });
      }

      wx.hideLoading();
    });
  },
  onReady: function () {
    // 页面渲染完成
  },
  onShow: function () {
    // 页面显示
  },
  onHide: function () {
    // 页面隐藏
  },
  onUnload: function () {
    // 页面关闭
  }
})