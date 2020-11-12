var api = require('../../../config/api.js');
var check = require('../../../utils/check.js');

var app = getApp();
Page({
  data: {
    mobile: '',
    code: '',
    password: '',
    confirmPassword: ''
  },
  onLoad: function(options) {
    // 页面初始化 options为页面跳转所带来的参数
    // 页面渲染完成

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

  },

  sendCode: function() {
    let that = this;
    wx.request({
      url: api.AuthRegisterCaptcha,
      data: {
        mobile: that.data.mobile
      },
      method: 'POST',
      header: {
        'content-type': 'application/json'
      },
      success: function(res) {
        if (res.data.errno == 0) {
          wx.showModal({
            title: '성공적으로 보냈습니다.',
            content: '확인 코드가 전송되었습니다.',
            showCancel: false
          });
        } else {
          wx.showModal({
            title: '에러 메시지',
            content: res.data.errmsg,
            showCancel: false
          });
        }
      }
    });
  },
  startReset: function() {
    var that = this;

    if (this.data.mobile.length == 0 || this.data.code.length == 0) {
      wx.showModal({
        title: '에러 메시지',
        content: '휴대폰 번호와 인증 코드는 비워 둘 수 없습니다.',
        showCancel: false
      });
      return false;
    }

    if (!check.isValidPhone(this.data.mobile)) {
      wx.showModal({
        title: '에러 메시지',
        content: '잘못된 전화 번호를 입력했습니다.',
        showCancel: false
      });
      return false;
    }

    if (this.data.password.length < 3) {
      wx.showModal({
        title: '에러 메시지',
        content: '사용자 이름과 비밀번호는 3 자리 이상이어야합니다.',
        showCancel: false
      });
      return false;
    }

    if (this.data.password != this.data.confirmPassword) {
      wx.showModal({
        title: '에러 메시지',
        content: '암호가 일치하지 않는지 확인',
        showCancel: false
      });
      return false;
    }

    wx.request({
      url: api.AuthReset,
      data: {
        mobile: that.data.mobile,
        code: that.data.code,
        password: that.data.password
      },
      method: 'POST',
      header: {
        'content-type': 'application/json'
      },
      success: function(res) {
        if (res.data.errno == 0) {
          wx.navigateBack();
        } else {
          wx.showModal({
            title: '비밀번호 재설정 실패',
            content: res.data.errmsg,
            showCancel: false
          });
        }
      }
    });
  },
  bindPasswordInput: function(e) {

    this.setData({
      password: e.detail.value
    });
  },
  bindConfirmPasswordInput: function(e) {

    this.setData({
      confirmPassword: e.detail.value
    });
  },
  bindMobileInput: function(e) {

    this.setData({
      mobile: e.detail.value
    });
  },
  bindCodeInput: function(e) {

    this.setData({
      code: e.detail.value
    });
  },
  clearInput: function(e) {
    switch (e.currentTarget.id) {
      case 'clear-password':
        this.setData({
          password: ''
        });
        break;
      case 'clear-confirm-password':
        this.setData({
          confirmPassword: ''
        });
        break;
      case 'clear-mobile':
        this.setData({
          mobile: ''
        });
        break;
      case 'clear-code':
        this.setData({
          code: ''
        });
        break;
    }
  }
})