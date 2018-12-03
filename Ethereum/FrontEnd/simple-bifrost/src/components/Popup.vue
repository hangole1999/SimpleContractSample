
<template>
  <transition name="popup">
    <div class="register-player popup-mask">
      <div class="popup-wrapper">
        <div class="popup-container">

          <div class="popup-header">
            <slot name="header">
              <label>Popup</label>
            </slot>
          </div>

          <div class="popup-body">
            <slot name="body">
              <p>Some Message</p>
            </slot>
          </div>

          <div class="popup-footer">
            <slot name="footer">

            </slot>
            <button class="popup-close-button" @click="$emit('close')">X</button>
          </div>
        </div>
      </div>
    </div>
  </transition>
</template>

<script>
export default {
  name: 'Popup'
}
</script>
