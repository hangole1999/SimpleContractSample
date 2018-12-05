#include <eosiolib/eosio.hpp>
#include <eosiolib/print.hpp>

using namespace eosio;

class simplectr : public eosio::contract {
  public:
      using contract::contract;

      int64_t data;

      /// @abi action
      void setdata( int64_t data ) {
         print("{\"from\": \"simplectrc\",\"to\": \"simplectrc\",\"name\": \"setdatacore\",\"data\": ");
         print(data);
         print("}");
      }

      void cbsetdata( int64_t data ) {
         this->data = data;

         print("cbsetdata(");
         print(data);
         print(")");
      }
};

EOSIO_ABI( simplectr, (setdata) (cbsetdata) )
