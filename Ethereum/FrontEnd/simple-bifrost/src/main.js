import Vue from 'vue'
import App from './App.vue'
import router from './router'
import { store } from './store';
import axios from 'axios';
import VueSocketIO from 'vue-socket.io'

axios.defaults.headers.post['Content-Type'] = 'application/x-www-form-urlencoded';
Vue.prototype.$http = axios;
Vue.use(new VueSocketIO({
  debug: true,
  connection: 'http://layer7.kr:3000',
  vuex: {
      store,
      actionPrefix: 'SOCKET_',
      mutationPrefix: 'SOCKET_'
  }
}));

Vue.config.productionTip = false;

new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app')
