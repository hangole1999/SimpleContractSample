
<template lang="html">
  <div id="app">
    <div class="background"></div>
    <Header></Header>
    <router-view @openPopup="openPopup"></router-view>
    <Popup v-if="showPopup" @close="closePopup">
      <label slot="header">
        {{popup.header}}
      </label>
      <p slot="body">
        {{popup.body}}
      </p>
      <div slot="footer">
        {{popup.footer}}
      </div>
    </Popup>
  </div>
</template>

<script>
import Header from './components/Header.vue';
import Popup from './components/Popup.vue';

export default {
  name: 'SimpleBifrost',
  components: { 
    Header,
    Popup
  },
  data () {
    return {
      popup: {
        show: false,
        header: '',
        body: '',
        footer: ''
      }
    };
  },
  computed: {
    showPopup() {
      return this.popup.show;
    }
  },
  methods: {
    openPopup(header, body, footer) {
        this.popup.show = true;
        this.popup.header = header;
        this.popup.body = body;
        this.popup.footer = footer;
    },
    closePopup() {
        this.popup.show = false;
        this.popup.header = '';
        this.popup.body = '';
        this.popup.footer = '';
    },
  },
  beforeCreate () {
    console.log('registerWeb3 Action dispatched from wanted-eth-dapp.vue');
    this.$store.dispatch('registerWeb3');
  }
};
</script>

<style>
@import "assets/css/styles.css";
</style>
