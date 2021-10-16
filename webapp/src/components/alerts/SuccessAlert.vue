<template>
  <v-alert
    v-model="alert"
    dismissible
    color="cyan"
    border="left"
    elevation="2"
    colored-border
    icon="mdi-twitter"
    type="success"
  >
    You've got <strong>5</strong> new updates on your timeline!.
  </v-alert>
</template>

<script>
export default {
  name: "alert",
  data() {
    return {
      alert: true,
    };
  },
};
</script>