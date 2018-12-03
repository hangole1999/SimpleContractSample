<template>
  <div class="home">
    <h1>Create Collectible</h1>

    <div class="content">
      <div class="input-field">
        <a class="button" @click="createCollection">Create Collectible</a>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'create',
  methods: {
    createCollection: function() {
      var address = this.$store.state.web3.coinbase;
      if (address == '') {
        return;
      }
      console.log(address);
      
      this.$axios.post('http://layer7.kr:3000/public/contract/send', {
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
