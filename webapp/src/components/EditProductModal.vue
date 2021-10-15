<template>
  <v-dialog v-model="dialog" persistent max-width="600px">
    <template v-slot:activator="{ on, attrs }">
      <v-btn v-show="!hidden" color="orange" icon v-bind="attrs" v-on="on">
        <v-icon>mdi-square-edit-outline</v-icon>
      </v-btn>
    </template>

    <v-card>
      <v-card-title>
        <span class="text-h5">Editar Produto</span>
      </v-card-title>

      <v-card-text>
        <v-form ref="editProductForm">
          <v-container>
            <v-row>
              <v-col cols="12">
                <v-text-field
                  label="Nome do produto*"
                  required
                  v-model="product[1]"
                  :rules="nameRules"
                />
              </v-col>

              <v-col cols="4">
                <v-text-field
                  label="Quantidade"
                  required
                  v-model.number="product[2]"
                  :rules="inputRules"
                />
              </v-col>

              <v-col cols="4">
                <v-text-field
                  label="Preço*"
                  v-model.number="product[3]"
                  required
                  :rules="inputRules"
                />
              </v-col>

              <v-col cols="4">
                <v-text-field
                  label="min*"
                  required
                  v-model.number="product[4]"
                />
              </v-col>

              <v-col cols="12" sm="6">
                <v-select
                  :items="['Bebida', 'Comida', 'Utensílio', 'higiene']"
                  v-model="product[7]"
                  label="Categoria*"
                  :rules="categoryRules"
                  required
                ></v-select>
              </v-col>
            </v-row>
          </v-container>
        </v-form>
      </v-card-text>

      <v-card-actions>
        <v-spacer></v-spacer>
        <v-btn color="blue darken-1" text @click="dialog = false">
          Close
        </v-btn>
        <v-btn color="blue darken-1" text @click="update(product)">
          Atualizar
        </v-btn>
      </v-card-actions>
    </v-card>
  </v-dialog>
</template>


<script>
import { mapActions } from "vuex";
export default {
  name: "EditProductModal",
  props: ["product"],
  data: () => ({
    dialog: false,
    hidden: false,
    inputRules: [(v) => v > 0 || "na numero"],
    nameRules: [(v) => v.length >= 3 || "Nome inválido"],
    categoryRules: [(v) => v !== null || "Escolha uma categoria"],
  }),
  methods: {
    ...mapActions(["updateProduct"]),
    update(product) {
      if (this.$refs.editProductForm.validate()) {
        this.dialog = false;
        switch (product[7]) {
          case "Bebida":
            product[6] = 1;
            break;
          case "Comida":
            product[6] = 2;
            break;
          case "Utensílio":
            product[6] = 3;
            break;
          case "Higiene":
            product[6] = 4;
            break;
          default:
            product[6] = 1;
        }

        this.updateProduct(product);
      }
    },
  },
};
</script>