#include <eosiolib/eosio.hpp>
#include <eosiolib/print.hpp>

using namespace eosio;

class simplecontractcore : public eosio::contract {
  public:
      using contract::contract;

      int64_t data;

      /// @abi action 
      void setdatacore( int64_t data ) {
         this.data = data;
         print( this.data );
      }
};

EOSIO_ABI( simplecontractcore, (setdatacore) )
