<template>
  <div class="home">
    <h1>Simple Bifrost Blog</h1>

    <div class="content">
      <div class="input-field">
        <input v-model="dataId" name="dataId" type="text" placeholder="Input Post ID"/>
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
    getPost() {
      var data = this.dataId;
      var address = this.$store.state.web3.coinbase;
      if (data == '' || address == '') {
        return;
      }
      console.log(data);
      console.log(address);

      var _this = this;
      
      this.$http.post('http://layer7.kr:3000/public/contract/call', {
        name: 'test',
        method: 'getDataById',
        args: '[' + data + ']'
      }).then(function(result) {
        console.log(result);
        _this.$emit('openPopup', "Post Writer: " + result.data.data[1], result.data.data[0], "Write at " + result.data.data[2]);
      });
    }
  }
}
</script>
