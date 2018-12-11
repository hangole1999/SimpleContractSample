<template>
  <div class="home">
    <h1>Bifrost Collectible</h1>
    <p>Enjoy your beautiful collection.</p>

    <div class="content">
      <div class="input-field">
        <input ref="collectionIdInput" v-model="collectionId" name="collectionId" type="text" placeholder="Input Collectible ID"/>
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
      collectionId: 0,
      dna: 0
    };
  },
  computed: {
    hashRobotUrl() {
      return 'https://robohash.org/' + this.getDna() + '?size=200x200';
    }
  },
  methods: {
    getCollectible() {
      var collectionId = this.collectionId;
      var address = this.$store.state.web3.coinbase;

      if (collectionId == '' || address == '') {
        this.$emit('openPopup', {text: "Can't get Collection!", error: true}, ["Check the Collection Identity or Wallet!"], "");
        return;
      }

      var body = {
        name: 'SimpleBifrostCollectible',
        method: 'getCollectionById',
        args: '[' + collectionId + ']'
      };

      this.$emit('loading', true);
      //${'https://cors-anywhere.herokuapp.com/'}
      this.$http.post(`http://layer7.kr:3000/public/contract/call`, body).then(result => {
        console.log(result);
        this.$emit('loading', false);

        this.dna = result.data.data[2];
        this.$emit('openPopup', "How about this collection in your view?", [{src: this.hashRobotUrl}, "Owner: " + result.data.data[1], "DNA: " + result.data.data[2]], "");
      }).catch(error => {
        console.error(error);
        this.$emit('loading', false);
        this.$emit('openPopup', {text: "Can't get Collection!", error: true}, ["Network Error"], "");
      });
    },
    getDna() {
      return this.dna;
    }
  },
  mounted() {
    this.$refs.collectionIdInput.value = '';
    this.$refs.collectionIdInput.focus();
  }
}
</script>
