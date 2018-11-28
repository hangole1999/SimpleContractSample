<template>
  <div class="post-form">
    <h1>Write Post</h1>
    <form method="post" action="http://layer7.kr:3000/public/contract/call">
      <div class="input-field">
        <div ref="data" name="data" type="text" placeholder="Input content here !" contentEditable="true" class="textarea"></div>
      </div>
      <div class="input-field">
        <a class="button" @click="submit">Write</a>
      </div>
    </form>
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
      this.$axios.post('http://layer7.kr:3000/public/contract/call', {
        name: 'simpleblog',
        method: 'writeData',
        args: '["' + data + '"]'
      }).then(function(result) {
        console.log(result);
      });
      this.$router.replace('/blog');
    }
  }
}
</script>
