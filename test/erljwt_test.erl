-module(erljwt_test).
-include_lib("eunit/include/eunit.hrl").

-define(RSA_PUBLIC_KEY,[65537, 26764034142824704671470727133910664843434961952272064166426226039805773031712563508339384620585192869091085197093344386232207542619708787421377966896296841271368128705832667137731759368836398793992412062213039259549646668413294499661784015754202306959856976300366659103241590400757099670805804654764282426982148086034348017908262389651476327142185608358813461989019448157613779262598416478574844583047253739496922447827706849259886451307152776609476861777213322863455948194927465841543344937499194416674011076061250124513400818349182398008202094247204740240584520318269147256825860139612842332966614539793342302993867]).

-define(RSA_PRIVATE_KEY,{'RSAPrivateKey','two-prime',
                     26764034142824704671470727133910664843434961952272064166426226039805773031712563508339384620585192869091085197093344386232207542619708787421377966896296841271368128705832667137731759368836398793992412062213039259549646668413294499661784015754202306959856976300366659103241590400757099670805804654764282426982148086034348017908262389651476327142185608358813461989019448157613779262598416478574844583047253739496922447827706849259886451307152776609476861777213322863455948194927465841543344937499194416674011076061250124513400818349182398008202094247204740240584520318269147256825860139612842332966614539793342302993867,
                     65537,
                     12794561693313670100205653006781224797363586340001583385478945661643268216176428806876618096082122962427692741885262975428461209855127276346365743059050308024962440641984489088989975449374313353003376259351732914257448923835215476363026888834996387949590598707455138772060958348043394306824326103327356583873848688304161573971837684253713093328415056019518486753353685104889273063916897235433180509399999298673446273215515841603080826297295537431001587831668670650206107678796371102894820869947413565783400511327660856890784768064128415588379491565702377411884622967328023716684228979596814867941892555080877039934913,
                     175921812047663448018479509235149059234162469604896431741565550421215807198867689136961832929735756392012649052466171066035877581304404480112067613119039884401516991962137582818872105841975489123820547558891955007907269296649095288060806030752931271323412548318651305799213788576544135388323426837173991918523,
                     152135962171497984267966543913856108347630812566910071974963337510843417419284055362416709755317088206676526904022621662056506919405421710738842624864481880983646685082220280096388715674338529824473346539992718562264652001183670660912857359719070110573506895077317198382716742487416742094479674005148886682929,
                     7940197446282076983057851111853928577973550591136055130560613060499509554820187443232572467555096623397064496348550193224195887597821512308642385211500678670974979968933624822287008698606336830008410206130924560376424044119932616111263320551248465760938924850490113410044316746409166615479205587444659781421,
                     84323951750609034263605058328437724273733757518546902734188980805978106073752129499973861816407422205891707581802977430675841339203838192816095615426435514697513859890011011710962053448744176509055866351301333624887673893266350866802867747864492145911204937114661141511698516423629600936600304533882132364273,
                     146498358518282536624753849370270691372323087909948725666061752883743908775492534384951112165832037025133690750650675527600809535328134914630670173454194925358833883485231412349407499865536427735554260391108738360645045140719276539512627330123338501657698608899096243687786198062042440767530650052735017635902,
                     asn1_NOVALUE}).

rs256_verification_test() ->
    IdToken =
    <<"eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE0NjA2MzE4MjEsImlzcyI6Imh0dHBzOi8vcHJvdG9uLnNjYy5raXQuZWR1Iiwic3ViIjoiam9lIiwiYXVkIjoiMTIzIiwiaWF0IjoxNDYwNjMxNTIxLCJhdXRoX3RpbWUiOjE0NjA2MzE1MjF9.nUKMCw_ppksTD49qWR7hs_FTNnVu2qaohnh67jANI9Cje7gaFi2puIsXbC_i0HoFnppR5mA_3B20f7X8O3UF3ZrgYyfjjAq5U3HeZ-Tx6xEd2EcJ-gfpVnoAJPa46Lx77NmApUyTAazXj8kjzgkh58_QDxujG13g55ckRG9qJfK3bX_h0ec07ARJWQSg_Zh8Q3lFB_iIbSDXOYegSAHhIpTxmuTA-qmPn3ySGIRirQt_-niek0-wyy5PAsxSU9lc42QIG7qdMLhvXsq5j52kPO9DA3vJNpGTloJ8H1AoE-ES8HpXH3RhRMe3cdiVyK2vTsPbRc0-GxkRZMKaocyOPQ">>,


    ExpPreParse = #{claims => #{exp => 1460631821,
                                iss => <<"https://proton.scc.kit.edu">>,
                                sub => <<"joe">>,
                                <<"aud">> => <<"123">>,
                                <<"auth_time">> => 1460631521,
                                <<"iat">> => 1460631521},
                    header => #{alg => <<"RS256">>,typ => <<"JWT">>}, signature => <<"nUKMCw_ppksTD49qWR7hs_FTNnVu2qaohnh67jANI9Cje7gaFi2puIsXbC_i0HoFnppR5mA_3B20f7X8O3UF3ZrgYyfjjAq5U3HeZ-Tx6xEd2EcJ-gfpVnoAJPa46Lx77NmApUyTAazXj8kjzgkh58_QDxujG13g55ckRG9qJfK3bX_h0ec07ARJWQSg_Zh8Q3lFB_iIbSDXOYegSAHhIpTxmuTA-qmPn3ySGIRirQt_-niek0-wyy5PAsxSU9lc42QIG7qdMLhvXsq5j52kPO9DA3vJNpGTloJ8H1AoE-ES8HpXH3RhRMe3cdiVyK2vTsPbRc0-GxkRZMKaocyOPQ">> },
    Header = maps:get(header, ExpPreParse),
    ExpPreParse = erljwt:pre_parse_jwt(IdToken),
    Header = erljwt:get_jwt_header(IdToken),
    expired = erljwt:parse_jwt(IdToken,?RSA_PUBLIC_KEY),
    ok.


rsa256_roundtrip_test() ->
    Claims = #{exp => 1460632831,
               iss => <<"me">>,
               sub => <<"789049">>,
               <<"aud">> => <<"someone">>,
               <<"azp">> => <<"thesameone">>,
               <<"nonce">> => <<"WwiTGOVNCSTn6tXFp8iW_wsugAp1AGm-81VJ9n4oy7Bauq0xTKg">>},

    JWT = erljwt:jwt(rs256,Claims, 10, ?RSA_PRIVATE_KEY),
    ClaimsWithExp = erljwt:parse_jwt(JWT,?RSA_PUBLIC_KEY),
    true = is_map(ClaimsWithExp),
    ClaimsWithExp = maps:put(exp,maps:get(exp,ClaimsWithExp),Claims),
    ok.


hs256_test() ->
    Claims = #{exp => 1460632831, iss => <<"me">>,
               sub => <<"789049">>,
               <<"aud">> => <<"someone">>,
               <<"azp">> => <<"thesameone">>,
               <<"nonce">> => <<"WwiTGOVNCSTn6tXFp8iW_wsugAp1AGm-81VJ9n4oy7Bauq0xTKg">>},
    Key = <<"my secret key">>,

    JWT = erljwt:jwt(hs256,Claims, 10, Key),
    ClaimsWithExp = erljwt:parse_jwt(JWT,Key),
    true = is_map(ClaimsWithExp),
    ClaimsWithExp = maps:put(exp,maps:get(exp,ClaimsWithExp),Claims),
    ok.

none_alg_test() ->
    Claims = #{exp => 1460632831, iss => <<"me">>,
               sub => <<"789049">>,
               <<"aud">> => <<"someone">>,
               <<"azp">> => <<"thesameone">>,
               <<"nonce">> => <<"WwiTGOVNCSTn6tXFp8iW_wsugAp1AGm-81VJ9n4oy7Bauq0xTKg">>},

    JWT = erljwt:jwt(none, Claims, 10, undefined),
    ClaimsWithExp = erljwt:parse_jwt(JWT,undefined),
    true = is_map(ClaimsWithExp),
    ClaimsWithExp = maps:put(exp,maps:get(exp,ClaimsWithExp),Claims),
    ok.

unsupported_alg_test() ->
    Claims = #{exp => 1460632831, iss => <<"me">>,
               sub => <<"789049">>,
               <<"aud">> => <<"someone">>,
               <<"azp">> => <<"thesameone">>,
               <<"nonce">> => <<"WwiTGOVNCSTn6tXFp8iW_wsugAp1AGm-81VJ9n4oy7Bauq0xTKg">>},
    Key = <<"my secret key">>,

    alg_not_supported = erljwt:jwt(xy21,Claims, 10, Key),
    ok.
