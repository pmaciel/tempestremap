
foreach( _t
  generate_testdata.sh
  run.sh
  run_fvtofv_ico.sh
  run_fvtofv_ico_diffnorms.sh
  run_fvtofv_rll.sh
  run_fvtofv_rll_diffnorms.sh
  run_fvtogll_cs.sh
  run_fvtogll_cs_diffnorms.sh
  run_fvtogll_cs_m.sh
  run_fvtogll_cs_m_diffnorms.sh
  run_fvtogll_ico.sh
  run_fvtogll_ico_diffnorms.sh
  run_fvtogll_rll.sh
  run_fvtogll_rll_diffnorms.sh
  run_glltofv_cst.sh
  run_glltofv_cst_m.sh
  run_glltofv_flag.sh
  run_glltofv_ico.sh
  run_glltofv_rll.sh
  run_glltofv_rll_diffnorms.sh
  run_glltofv_rll_m.sh
  run_glltofv_rll_m_diffnorms.sh
  run_glltogll_cs.sh
  run_glltogll_cs_diffnorms.sh
  testdata_diffnorms_mono.sh )
    add_test(
        NAME              ${_t}
        COMMAND           ${_t}
        TYPE              SCRIPT
        #ENVIRONMENT       ${_testEnvironment}
        WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} )
endforeach()


