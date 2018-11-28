
<template lang="html">
  <div id="app">
    <div class="background"></div>
    <Header></Header>
    <router-view></router-view>
  </div>
</template>

<script>
import Header from './components/Header.vue';

export default {
  name: 'SimpleBifrost',
  components: { 
    Header
  },
  data () {
    return {
      popup: {
        show: ''
      }
    };
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
