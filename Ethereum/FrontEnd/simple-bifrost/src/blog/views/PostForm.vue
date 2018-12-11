<template>
  <div class="post-form">
    <h1>Bifrost Blog</h1>
    <p>Use your writing skills.</p>

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

      if (this.$refs["data"].innerText == '' || address == '') {
        this.$emit('openPopup', {text: "Can't write Post!", error: true}, ["Check the Post Form or Wallet!"], "");
        return;
      }

      var body = {
        name: 'SimpleBifrostBlog',
        method: 'writeData',
        args: '["'+data+'"]',
        gas: 100000
      };
      
      this.$emit('loading', true);

      this.$http.post(`${'https://cors-anywhere.herokuapp.com/'}http://layer7.kr:3000/public/contract/send`, body).then(result => {
        console.log(result);
        this.$emit('loading', false);

        if (result.data.success) {
          this.$emit('openPopup', "Successfully send transaction", ["Successfully send transaction at " + result.data.blockHash], "It may not have been reflected yet");
          this.$router.replace('/blog');
        }
      }).catch(error => {
        console.error(error);
        this.$emit('loading', false);
        this.$emit('openPopup', {text: "Can't write Post!", error: true}, ["Network Error"], "");
      });
    }
  },
  mounted() {
    this.$refs.data.focus();
  }
}
</script>
