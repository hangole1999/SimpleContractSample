#include <eosiolib/eosio.hpp>
#include <eosiolib/print.hpp>

using namespace eosio;
using std::string;

class test : public eosio::contract {
  public:
      using contract::contract;

      /// @abi action 
      void hello( int64_t data ) {
         print ("{\"onhello\": {\"data\": \"");
         print (data);
         print ("\"}}");
      }
};

EOSIO_ABI( test, (hello) )
