
<template>
  <div class="navigation">
    <ul>
      <li>
        <router-link to="/collectible"><i class="material-icons">person</i></router-link>
      </li>
      <li>
        <router-link to="/collectible/create"><i class="material-icons">person_add</i></router-link>
      </li>
    </ul>
  </div>
</template>

<script>
export default {
  name: 'Navigation'
}
</script>
