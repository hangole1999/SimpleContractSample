<template>
  <div class="post-form">
    <h1>Write Post</h1>

    <div class="content">
      <div class="input-field">
        <div ref="data" name="data" type="text" placeholder="Input content here !" contentEditable="true" class="textarea"></div>
      </div>
      <div class="input-field">
        <a class="button" @click="submit">Write</a>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'postForm',
  methods: {
    submit: function() {
      var data = web3.toHex(this.$refs["data"].innerText);
      var address = this.$store.state.web3.coinbase;
      if (data == '' || address == '') {
        return;
      }
      console.log(data);
      console.log(address);

      var _this = this;
      
      this.$http.post('http://layer7.kr:3000/public/contract/send', {
        name: 'test',
        method: 'writeData',
        args: '["' + data + '"]'
      }).then(function(result) {
        console.log(result);
        if (result.success) {
          _this.$router.replace('/blog');
        }
      });
    }
  }
}
</script>
