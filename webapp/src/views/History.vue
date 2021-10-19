<template>
  <div>
    <v-container>
      <v-row>
        <v-col>
          <SalesHistory />
        </v-col>

        <v-col>
          <PurchasesHistory />
        </v-col>
      </v-row>
    </v-container>
  </div>
</template>


<script>
import SalesHistory from "../components/SalesHistory.vue";
import PurchasesHistory from "../components/PurchasesHistory.vue";
export default {
  name: "History",
  components: {
    SalesHistory,
    PurchasesHistory,
  },
  data() {
    return {};
  },
};
</script>
