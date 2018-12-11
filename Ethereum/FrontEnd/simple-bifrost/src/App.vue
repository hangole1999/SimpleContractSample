
<template lang="html">
  <div id="app">
    <div class="background"></div>
    <Header></Header>
    <router-view @openPopup="openPopup" @loading="loading"></router-view>
    <Popup v-if="showPopup" @close="closePopup">
      <div slot="header">
        <label v-if="popup.header.error == true" class="error">{{popup.header.text}}</label>
        <label v-else>{{popup.header}}</label>
      </div>
      <div v-for="(bodyContent, index) in popup.body" :key="index" :class="[bodyContent.src != undefined ? 'img' : '']" slot="body">
        <img v-if="bodyContent.src != undefined" :src="bodyContent.src" />
        <p v-else>{{bodyContent}}</p>
      </div>
      <div slot="footer">
        {{popup.footer}}
      </div>
    </Popup>
    <Spinner v-if="isLoading"></Spinner>
  </div>
</template>

<script>
import Header from './components/Header.vue';
import Popup from './components/Popup.vue';
import Spinner from './components/Spinner.vue';

export default {
  name: 'SimpleBifrost',
  components: {
    Header,
    Popup,
    Spinner
  },
  data () {
    return {
      popup: {
        show: false,
        header: '',
        body: '',
        footer: ''
      },
      isLoading: false
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
    loading(isLoading) {
      this.isLoading = isLoading;
    }
  },
  beforeCreate () {
    console.log('registerWeb3 Action dispatched from wanted-eth-dapp.vue');
    this.$store.dispatch('registerWeb3');

    this.sockets.subscribe('event', (data) => {
      console.log("socketio:event");
      console.log(data);
    });console.log(this.$store);
  }
};
</script>

<style>
@import "assets/css/styles.css";
</style>
