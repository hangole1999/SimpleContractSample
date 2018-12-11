<template>
  <div class="home">
    <h1>Bifrost Collectible</h1>
    <p>What collection is waiting for you this time?</p>

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
        this.$emit('openPopup', {text: "Can't create Collection!", error: true}, ["Check the Wallet!"], "");
        return;
      }

      var body = {
        name: 'SimpleBifrostCollectible',
        method: 'createCollection',
        args: '[]',
        gas: 100000
      };
      
      this.$emit('loading', true);

      this.$http.post(`${'https://cors-anywhere.herokuapp.com/'}http://layer7.kr:3000/public/contract/send`, body).then(result => {
        console.log(result);
        this.$emit('loading', false);

        if (result.data.success) {
          this.$emit('openPopup', "Successfully send transaction", ["Successfully send transaction at " + result.data.blockHash], "It may not have been reflected yet");
          this.$router.replace('/collectible');
        }
      }).catch(error => {
        console.error(error);
        this.$emit('loading', false);
        this.$emit('openPopup', {text: "Can't create Collection!", error: true}, ["Network Error"], "");
      });
    }
  }
}
</script>
