<template>
  <div class="home">
    <h1>Simple Bifrost Collectible</h1>

    <div class="content">
      <div class="input-field">
        <input v-model="collectionId" name="collectionId" type="text" placeholder="Input Collectible ID"/>
      </div>
      <div class="input-field">
        <a class="button" @click="getCollectible">Get Collectible</a>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'home',
  data() {
    return {
      collectionId: 0
    };
  },
  methods: {
    getCollectible() {
      var data = this.collectionId;
      var address = this.$store.state.web3.coinbase;
      if (data == '' || address == '') {
        return;
      }
      console.log(data);
      console.log(address);

      var _this = this;
      
      this.$http.post('http://layer7.kr:3000/public/contract/call', {
        name: 'test',
        method: 'getCollectionById',
        args: '[' + data + ']'
      }).then(function(result) {
        console.log(result);
        _this.$emit('openPopup', "Owner: " + result.data.data[1], "DNA: " + result.data.data[2], "");
      });
    }
  }
}
</script>
