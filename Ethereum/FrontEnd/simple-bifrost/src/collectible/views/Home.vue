<template>
  <div class="home">
    <h1>Simple Bifrost Collectible</h1>

    <a class="button" @click="submit">Create Collectible</a>
  </div>
</template>

<script>
export default {
  name: 'home',
  methods: {
    submit: function() {
      var address = this.$store.state.web3.coinbase;
      if (address == '') {
        return;
      }
      console.log(address);
      this.$axios.post('http://layer7.kr:3000/public/contract/call', {
        name: 'simplecollectible',
        method: 'createCollection',
        args: '[]'
      }).then(function(result) {
        console.log(result);
      });
    }
  }
}
</script>
