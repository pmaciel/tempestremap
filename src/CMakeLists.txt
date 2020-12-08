
add_library(TempestRemap SHARED
	Announce.cpp
	ApplyOfflineMap.cpp
	FiniteElementTools.cpp
	FiniteVolumeTools.cpp
	GaussLobattoQuadrature.cpp
	GaussQuadrature.cpp
	GenerateCSMesh.cpp
	GenerateConnectivityData.cpp
	GenerateGLLMetaData.cpp
	GenerateICOMesh.cpp
	GenerateLambertConfConicMesh.cpp
	GenerateOfflineMap.cpp
	GenerateOverlapMesh.cpp
	GenerateOverlapMesh_v1.cpp
	GenerateRLLMesh.cpp
	GenerateStereographicMesh.cpp
	GenerateTransectMesh.cpp
	GenerateUTMMesh.cpp
	GridElements.cpp
	LegendrePolynomial.cpp
	LinearRemapFV.cpp
	LinearRemapSE0.cpp
	MeshUtilities.cpp
	MeshUtilitiesExact.cpp
	MeshUtilitiesFuzzy.cpp
	NetCDFUtilities.cpp
	OfflineMap.cpp
	OverlapMesh.cpp
	PolynomialInterp.cpp
	TriangularQuadrature.cpp
	kdtree.cpp
	ncvalues.cpp
	netcdf.cpp
	triangle.cpp )

target_link_libraries(TempestRemap PUBLIC netcdf::netcdf LAPACK::LAPACK)


foreach( _src
  AnalyzeMap.cpp
  ApplyOfflineMapExe.cpp
  CalculateDiffNorms.cpp
  CoarsenRectilinearData.cpp
  ConvertExodusToSCRIP.cpp
  ConvertSCRIPToExodus.cpp
  GenerateCSMeshExe.cpp
  GenerateGLLMetaDataExe.cpp
  GenerateICOMeshExe.cpp
  GenerateLambertConfConicMeshExe.cpp
  GenerateOfflineMapExe.cpp
  GenerateOverlapMeshExe.cpp
  GenerateOverlapMeshExe_v1.cpp
  GenerateRLLMeshExe.cpp
  GenerateStereographicMeshExe.cpp
  GenerateTestData.cpp
  GenerateTransectMeshExe.cpp
  GenerateTransposeMap.cpp
  GenerateUTMMeshExe.cpp
  GenerateVolumetricMesh.cpp
  MeshToTxt.cpp
  ShpToMesh.cpp
  #UnitTest.cpp
  VerticalInterpolate.cpp )
    get_filename_component(_name ${_src} NAME_WLE)
    add_executable(${_name} ${_src})
    target_link_libraries(${_name} TempestRemap)
endforeach()


#foreach( _src
#  GenerateOfflineMap.cpp
#  GenerateOfflineMap_v1.cpp )
#    get_filename_component(_name ${_src} NAME_WLE)
#    add_executable(${_name} ${_src})
#    target_link_libraries(${_name} TempestRemap)
#    target_compile_definitions(${_name} PRIVATE TEMPEST_DRIVER_MODE)
#endforeach()

# TODO:
# ifdef TEMPEST_MPIOMP

