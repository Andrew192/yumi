var util = require('../../../utils/util.js');
var check = require('../../../utils/check.js');
var api = require('../../../config/api.js');

var app = getApp();

Page({
  data: {
    array: ['피드백 유형 ','제품 관련 ','기능 이상 ','최적화 제안 ','기타를 선택하세요.'],
    index: 0,
    content: '',
    contentLength: 0,
    mobile: '',
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
      console.log('업로드 진행률', res.progress)
      console.log('업로드 된 데이터의 길이', res.totalBytesSent)
      console.log('업로드 될 것으로 예상되는 총 데이터 길이', res.totalBytesExpectedToSend)
    })

  },
  previewImage: function(e) {
    wx.previewImage({
      current: e.currentTarget.id, // 当前显示图片的http链接
      urls: this.data.files // 需要预览的图片http链接列表
    })
  },
  bindPickerChange: function(e) {
    this.setData({
      index: e.detail.value
    });
  },
  mobileInput: function(e) {
    this.setData({
      mobile: e.detail.value
    });
  },
  contentInput: function(e) {
    this.setData({
      contentLength: e.detail.cursor,
      content: e.detail.value,
    });
  },
  clearMobile: function(e) {
    this.setData({
      mobile: ''
    });
  },
  submitFeedback: function(e) {
    if (!app.globalData.hasLogin) {
      wx.navigateTo({
        url: "/pages/auth/login/login"
      });
    }

    let that = this;
    if (that.data.index == 0) {
      util.showErrorToast('피드백 유형을 선택하십시오');
      return false;
    }

    if (that.data.content == '') {
      util.showErrorToast('피드백 내용을 입력하십시오');
      return false;
    }

    if (that.data.mobile == '') {
      util.showErrorToast('전화 번호를 입력하세요');
      return false;
    }

    if (!check.isValidPhone(this.data.mobile)) {
      this.setData({
        mobile: ''
      });
      util.showErrorToast('전화 번호를 입력하세요');
      return false;
    }

    wx.showLoading({
      title: '제출 중...',
      mask: true,
      success: function() {

      }
    });

    util.request(api.FeedbackAdd, {
      mobile: that.data.mobile,
      feedType: that.data.array[that.data.index],
      content: that.data.content,
      hasPicture: that.data.hasPicture,
      picUrls: that.data.picUrls
    }, 'POST').then(function(res) {
      wx.hideLoading();

      if (res.errno === 0) {
        wx.showToast({
          title: '귀하의 의견에 감사드립니다',
          icon: 'success',
          duration: 2000,
          complete: function() {
            that.setData({
              index: 0,
              content: '',
              contentLength: 0,
              mobile: '',
              hasPicture: false,
              picUrls: [],
              files: []
            });
          }
        });
      } else {
        util.showErrorToast(res.errmsg);
      }

    });
  },
  onLoad: function(options) {

  },
  onReady: function() {

  },
  onShow: function() {

  },
  onHide: function() {
    // 页面隐藏

  },
  onUnload: function() {
    // 页面关闭
  }
})