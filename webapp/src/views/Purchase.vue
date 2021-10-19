<template>
  <v-container>
    <v-row>
      <v-col cols="6">
        <v-card max-width="600">
          <v-card-title>
            <span class="text-h5">Nova Compra Produto</span>
          </v-card-title>

          <v-divider></v-divider>

          <v-card-text>
            <v-form ref="newProductForm">
              <v-container>
                <v-row>
                  <v-col cols="12"> </v-col>

                  <v-col cols="4">
                    <v-text-field
                      label="Quantidade"
                      required
                      v-model.number="purchase.price"
                      :rules="inputRules"
                    />
                  </v-col>

                  <v-col cols="4">
                    <v-text-field
                      label="Preço*"
                      v-model.number="purchase.insert"
                      required
                      :rules="inputRules"
                    />
                  </v-col>

                  <v-col cols="4">
                    <v-text-field
                      label="Preço*"
                      v-model.number="purchase.profit"
                      required
                      :rules="inputRules"
                    />
                  </v-col>
                </v-row>
              </v-container>
            </v-form>
          </v-card-text>

          <v-card-actions>
            <v-btn color="blue darken-1" text @click="doPurchase()">
              Adicionar a lista de compras
            </v-btn>
          </v-card-actions>
        </v-card>
      </v-col>

      <v-col cols="5">
        <v-card class="px-8">
          <v-card-title>
            <span class="text-h5">Lista de compras</span>
          </v-card-title>
          <v-divider></v-divider>
          <v-card-text>
            <p class="">Nome do produto</p>
          </v-card-text>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>


<script>
import { mapGetters } from "vuex";
export default {
  name: "Purchase",
  data: () => ({
    purchase: {
      name: "product Name bind to code",
      price: null,
      quantity: null,
      insert: true,
      profit: null,
      userId: "userId From Store",
      codProduct: "get from the formulary list",
      idSupplier: "get from the formulary list",
    },
    dialog: false,
    hidden: false,
    inputRules: [(v) => v > 0 || "na numero"],
    nameRules: [(v) => v.length >= 3 || "Nome inválido"],
    /*  categoryRules: [(v) => v !== null || "Escolha uma categoria"], */
  }),
  methods: {
    doPurchase() {
      if (this.$refs.newProductForm.validate()) {
        this.dialog = false;
      }
    },
  },
};
</script>
