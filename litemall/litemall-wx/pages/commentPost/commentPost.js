// 上传组件 基于https://github.com/Tencent/weui-wxss/tree/master/src/example/uploader
var app = getApp();
var util = require('../../utils/util.js');
var api = require('../../config/api.js');
Page({
  data: {
    orderId: 0,
    type: 0,
    valueId: 0,
    orderGoods: {},
    content: '',
    stars: [0, 1, 2, 3, 4],
    star: 5,
    starText: '매우 만족',
    hasPicture: false,
    picUrls: [],
    files: []
  },
  chooseImage: function(e) {
    if (this.data.files.length >= 5) {
      util.showErrorToast('5 장의 사진 만 업로드 할 수 있습니다.')
      return false;
    }

    var that = this;
    wx.chooseImage({
      count: 1,
      sizeType: ['original', 'compressed'],
      sourceType: ['album', 'camera'],
      success: function(res) {
        that.setData({
          files: that.data.files.concat(res.tempFilePaths)
        });
        that.upload(res);
      }
    })
  },
  upload: function(res) {
    var that = this;
    const uploadTask = wx.uploadFile({
      url: api.StorageUpload,
      filePath: res.tempFilePaths[0],
      name: 'file',
      success: function(res) {
        var _res = JSON.parse(res.data);
        if (_res.errno === 0) {
          var url = _res.data.url
          that.data.picUrls.push(url)
          that.setData({
            hasPicture: true,
            picUrls: that.data.picUrls
          })
        }
      },
      fail: function(e) {
        wx.showModal({
          title: '오류',
          content: '업로드 실패',
          showCancel: false
        })
      },
    })

    uploadTask.onProgressUpdate((res) => {
      console.log('업로드 실패', res.progress)
      console.log('업로드된 데이터 길이', res.totalBytesSent)
      console.log('업로드 될 것으로 예상되는 총 데이터 길이', res.totalBytesExpectedToSend)
    })

  },
  previewImage: function(e) {
    wx.previewImage({
      current: e.currentTarget.id, // 当前显示图片的http链接
      urls: this.data.files // 需要预览的图片http链接列表
    })
  },
  selectRater: function(e) {
    var star = e.currentTarget.dataset.star + 1;
    var starText;
    if (star == 1) {
      starText = '몹시 나쁜';
    } else if (star == 2) {
      starText = '나쁜';
    } else if (star == 3) {
      starText = '만족';
    } else if (star == 4) {
      starText = '상당히 만족';
    } else {
      starText = '매우 만족'
    }
    this.setData({
      star: star,
      starText: starText
    })

  },
  onLoad: function(options) {
    var that = this;
    that.setData({
      orderId: options.orderId,
      type: options.type,
      valueId: options.valueId
    });
    this.getOrderGoods();
  },
  getOrderGoods: function() {
    let that = this;
    util.request(api.OrderGoods, {
      orderId: that.data.orderId,
      goodsId: that.data.valueId
    }).then(function(res) {
      if (res.errno === 0) {
        that.setData({
          orderGoods: res.data,
        });
      }
    });
  },
  onClose: function() {
    wx.navigateBack();
  },
  onPost: function() {
    let that = this;

    if (!this.data.content) {
      util.showErrorToast('댓글을 작성 해주세요')
      return false;
    }

    util.request(api.OrderComment, {
      orderGoodsId: that.data.orderGoods.id,
      content: that.data.content,
      star: that.data.star,
      hasPicture: that.data.hasPicture,
      picUrls: that.data.picUrls
    }, 'POST').then(function(res) {
      if (res.errno === 0) {
        wx.showToast({
          title: '댓글 성공',
          complete: function() {
            wx.switchTab({
              url: '/pages/ucenter/index/index'
            })
          }
        })
      }
    });
  },
  bindInputValue(event) {

    let value = event.detail.value;

    //判断是否超过140个字符
    if (value && value.length > 140) {
      return false;
    }

    this.setData({
      content: event.detail.value,
    })
  },
  onReady: function() {

  },
  onShow: function() {
    // 页面显示

  },
  onHide: function() {
    // 页面隐藏

  },
  onUnload: function() {
    // 页面关闭

  }
})