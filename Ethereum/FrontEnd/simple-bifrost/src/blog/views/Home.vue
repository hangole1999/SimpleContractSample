<template>
  <div class="home">
    <h1>Bifrost Blog</h1>
    <p>What do you want to read today?</p>

    <div class="content">
      <div class="input-field">
        <input ref="dataIdInput" v-model="dataId" name="dataId" type="text" placeholder="Input Post ID"/>
      </div>
      <div class="input-field">
        <a class="button" @click="getPost">Get Post</a>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'home',
  data() {
    return {
      dataId: 0
    };
  },
  methods: {
    formatDate(dateValue) {
      var date = new Date(dateValue);

      var second = date.getSeconds();
      var minute = date.getMinutes();
      var hour = date.getHours();

      var day = date.getDate();
      var month = date.getMonth() + 1;
      var year = date.getFullYear();

      second = (second < 10) ? "0" + second : second;
      minute = (minute < 10) ? "0" + minute : minute;
      hour = (hour < 10) ? "0" + hour : hour;

      return year + '.' + month + '.' + day + ' ' + hour + ':' + minute + ':' + second;
    },
    getPost() {
      var dataId = this.dataId;
      var address = this.$store.state.web3.coinbase;

      if (dataId == '' || address == '') {
        this.$emit('openPopup', {text: "Can't get Post!", error: true}, ["Check the Post Identity or Wallet!"], "");
        return;
      }

      var body = {
        name: 'SimpleBifrostBlog',
        method: 'getDataById',
        args: '[' + dataId + ']'
      };
      
      this.$emit('loading', true);
      
      this.$http.post(`http://layer7.kr:3000/public/contract/call`, body).then(result => {
        console.log(result);
        this.$emit('loading', false);

        this.$emit('openPopup', "Is that what you were looking for?", ["Post Writer: " + result.data.data[1], web3.toAscii(result.data.data[0])], "Write at " + this.formatDate(result.data.data[2]));
      }).catch(error => {
        console.error(error);
        this.$emit('loading', false);
        this.$emit('openPopup', {text: "Can't get Post!", error: true}, ["Network Error"], "");
      });
    }
  },
  mounted() {
    this.$refs.dataIdInput.value = '';
    this.$refs.dataIdInput.focus();
  }
}
</script>
