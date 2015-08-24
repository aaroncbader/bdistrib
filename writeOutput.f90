subroutine writeOutput

  use globalVariables
  use read_wout_mod, only: nfp
  use ezcdf

  implicit none

  integer :: ierr, ncid

  ! Same convention as in VMEC:
  ! Prefix vn_ indicates the variable name used in the .nc file.
  character(len=*), parameter :: &
       vn_nfp = "nfp", &
       vn_geometry_option_plasma = "geometry_option_plasma", &
       vn_geometry_option_middle = "geometry_option_middle", &
       vn_geometry_option_outer = "geometry_option_outer", &
       vn_nu_plasma = "nu_plasma", &
       vn_nv_plasma = "nv_plasma", &
       vn_nvl_plasma = "nvl_plasma", &
       vn_nu_middle = "nu_middle", &
       vn_nv_middle = "nv_middle", &
       vn_nvl_middle = "nvl_middle", &
       vn_nu_outer = "nu_outer", &
       vn_nv_outer = "nv_outer", &
       vn_nvl_outer = "nvl_outer", &
       vn_u_plasma = "u_plasma", &
       vn_v_plasma = "v_plasma", &
       vn_vl_plasma = "vl_plasma", &
       vn_u_middle = "u_middle", &
       vn_v_middle = "v_middle", &
       vn_vl_middle = "vl_middle", &
       vn_u_outer = "u_outer", &
       vn_v_outer = "v_outer", &
       vn_vl_outer = "vl_outer", &
       vn_r_plasma  = "r_plasma", &
       vn_r_middle  = "r_middle", &
       vn_r_outer = "r_outer", &
       vn_drdu_plasma  = "drdu_plasma", &
       vn_drdu_middle  = "drdu_middle", &
       vn_drdu_outer = "drdu_outer", &
       vn_drdv_plasma  = "drdv_plasma", &
       vn_drdv_middle  = "drdv_middle", &
       vn_drdv_outer = "drdv_outer", &
       vn_normal_plasma = "normal_plasma", &
       vn_normal_middle = "normal_middle", &
       vn_normal_outer = "normal_outer", &
       vn_norm_normal_plasma  = "norm_normal_plasma", &
       vn_norm_normal_middle  = "norm_normal_middle", &
       vn_norm_normal_outer = "norm_normal_outer", &
       vn_mpol_plasma = "mpol_plasma", &
       vn_ntor_plasma = "ntor_plasma", &
       vn_mnmax_plasma = "mnmax_plasma", &
       vn_num_basis_functions_plasma = "num_basis_functions_plasma", &
       vn_xm_plasma = "xm_plasma", &
       vn_xn_plasma = "xn_plasma", &
       vn_mpol_middle = "mpol_middle", &
       vn_ntor_middle = "ntor_middle", &
       vn_mnmax_middle = "mnmax_middle", &
       vn_num_basis_functions_middle = "num_basis_functions_middle", &
       vn_xm_middle = "xm_middle", &
       vn_xn_middle = "xn_middle", &
       vn_mpol_outer = "mpol_outer", &
       vn_ntor_outer = "ntor_outer", &
       vn_mnmax_outer = "mnmax_outer", &
       vn_num_basis_functions_outer = "num_basis_functions_outer", &
       vn_xm_outer = "xm_outer", &
       vn_xn_outer = "xn_outer", &
       vn_basis_set_option = "basis_set_option", &
       vn_inductance_plasma = "inductance_plasma", &
       vn_inductance_middle = "inductance_middle", &
       vn_n_singular_values_inductance_plasma = "n_singular_values_inductance_plasma", &
       vn_n_singular_values_inductance_middle = "n_singular_values_inductance_middle", &
       vn_n_singular_values_transferMatrix = "n_singular_values_transferMatrix", &
       vn_svd_s_inductance_plasma = "svd_s_inductance_plasma", &
       vn_svd_s_inductance_middle = "svd_s_inductance_middle", &
       vn_pseudoinverse_thresholds = "pseudoinverse_thresholds", &
       vn_n_pseudoinverse_thresholds = "n_pseudoinverse_thresholds", &
       vn_n_singular_values_retained = "n_singular_values_retained", &
       vn_svd_s_transferMatrix = "svd_s_transferMatrix", &
       vn_svd_u_transferMatrix_sin = "svd_u_transferMatrix_sin", &
       vn_svd_u_transferMatrix_cos = "svd_u_transferMatrix_cos", &
       vn_svd_v_transferMatrix_sin = "svd_v_transferMatrix_sin", &
       vn_svd_v_transferMatrix_cos = "svd_v_transferMatrix_cos", &
       vn_n_singular_vectors_to_save = "n_singular_vectors_to_save", &
       vn_totalTime = "totalTime"

  ! Arrays with dimension 1:
  character(len=*), parameter, dimension(1) :: &
       nu_plasma_dim = (/'nu_plasma'/), &
       nv_plasma_dim = (/'nv_plasma'/), &
       nvl_plasma_dim = (/'nvl_plasma'/), &
       nu_middle_dim = (/'nu_middle'/), &
       nv_middle_dim = (/'nv_middle'/), &
       nvl_middle_dim = (/'nvl_middle'/), &
       nu_outer_dim = (/'nu_outer'/), &
       nv_outer_dim = (/'nv_outer'/), &
       nvl_outer_dim = (/'nvl_outer'/), &
       mnmax_plasma_dim = (/'mnmax_plasma'/), &
       mnmax_middle_dim = (/'mnmax_middle'/), &
       mnmax_outer_dim = (/'mnmax_outer'/), &
       n_singular_values_inductance_plasma_dim = (/'n_singular_values_inductance_plasma'/), &
       n_singular_values_inductance_middle_dim = (/'n_singular_values_inductance_middle'/), &
       n_pseudoinverse_thresholds_dim = (/'n_pseudoinverse_thresholds'/)

  ! Arrays with dimension 2:
  character(len=*), parameter, dimension(2) :: &
       u_vl_plasma_dim = (/'nu_plasma','nvl_plasma'/), &
       u_vl_middle_dim = (/'nu_middle','nvl_middle'/), &
       u_vl_outer_dim = (/'nu_outer','nvl_outer'/), &
       basis_plasma_outer_dim = (/'num_basis_functions_plasma','num_basis_functions_outer'/), &
       basis_middle_outer_dim = (/'num_basis_functions_middle','num_basis_functions_outer'/), &
       n_singular_values_thresholds_dim = &
            (/'n_singular_values_transferMatrix','n_pseudoinverse_thresholds'/)
!       uvl_plasma_dim = (/'nvl_plasma','nu_plasma'/)
!       u_v_uprime_vprime_plasma_dim = (/'nu_nv_plasma','nu_nv_outer'/),&
!       u_v_uprime_vprime_middle_dim = (/'nu_nv_middle','nu_nv_outer'/), &

  ! Arrays with dimension 3:
  character(len=*), parameter, dimension(3) :: &
       u_vl_xyz_plasma_dim  = (/'nu_plasma' ,'nvl_plasma' ,'xyz'/), &
       u_vl_xyz_middle_dim  = (/'nu_middle' ,'nvl_middle' ,'xyz'/), &
       u_vl_xyz_outer_dim = (/'nu_outer','nvl_outer','xyz'/), &
       mnmax_plasma_nsave_thresholds_dim = (/'mnmax_plasma','n_singular_vectors_to_save','n_pseudoinverse_thresholds'/), &
       mnmax_middle_nsave_thresholds_dim = (/'mnmax_middle','n_singular_vectors_to_save','n_pseudoinverse_thresholds'/)


  call cdf_open(ncid,outputFilename,'w',ierr)
  IF (ierr .ne. 0) then
     print *,"Error opening output file ",outputFilename
     stop
  end IF

  ! Scalars

  call cdf_define(ncid, vn_nfp, nfp)
  call cdf_define(ncid, vn_geometry_option_plasma, geometry_option_plasma)
  call cdf_define(ncid, vn_geometry_option_middle, geometry_option_middle)
  call cdf_define(ncid, vn_geometry_option_outer, geometry_option_outer)
  call cdf_define(ncid, vn_nu_plasma, nu_plasma)
  call cdf_define(ncid, vn_nv_plasma, nv_plasma)
  call cdf_define(ncid, vn_nvl_plasma, nvl_plasma)
  call cdf_define(ncid, vn_nu_middle, nu_middle)
  call cdf_define(ncid, vn_nv_middle, nv_middle)
  call cdf_define(ncid, vn_nvl_middle, nvl_middle)
  call cdf_define(ncid, vn_nu_outer, nu_outer)
  call cdf_define(ncid, vn_nv_outer, nv_outer)
  call cdf_define(ncid, vn_nvl_outer, nvl_outer)
  call cdf_define(ncid, vn_mpol_plasma, mpol_plasma)
  call cdf_define(ncid, vn_ntor_plasma, ntor_plasma)
  call cdf_define(ncid, vn_mnmax_plasma, mnmax_plasma)
  call cdf_define(ncid, vn_num_basis_functions_plasma, num_basis_functions_plasma)
  call cdf_define(ncid, vn_mpol_middle, mpol_middle)
  call cdf_define(ncid, vn_ntor_middle, ntor_middle)
  call cdf_define(ncid, vn_mnmax_middle, mnmax_middle)
  call cdf_define(ncid, vn_num_basis_functions_middle, num_basis_functions_middle)
  call cdf_define(ncid, vn_mpol_outer, mpol_outer)
  call cdf_define(ncid, vn_ntor_outer, ntor_outer)
  call cdf_define(ncid, vn_mnmax_outer, mnmax_outer)
  call cdf_define(ncid, vn_num_basis_functions_outer, num_basis_functions_outer)
  call cdf_define(ncid, vn_basis_set_option, basis_set_option)
  call cdf_define(ncid, vn_n_singular_values_inductance_plasma, n_singular_values_inductance_plasma)
  call cdf_define(ncid, vn_n_singular_values_inductance_middle, n_singular_values_inductance_middle)
  call cdf_define(ncid, vn_n_pseudoinverse_thresholds, n_pseudoinverse_thresholds)
  call cdf_define(ncid, vn_n_singular_vectors_to_save, n_singular_vectors_to_save)
  call cdf_define(ncid, vn_totalTime, totalTime)

  ! Arrays with dimension 1

  call cdf_define(ncid, vn_u_plasma, u_plasma, dimname=nu_plasma_dim)
  call cdf_define(ncid, vn_v_plasma, v_plasma, dimname=nv_plasma_dim)
  call cdf_define(ncid, vn_vl_plasma, vl_plasma, dimname=nvl_plasma_dim)
  call cdf_define(ncid, vn_u_middle, u_middle, dimname=nu_middle_dim)
  call cdf_define(ncid, vn_v_middle, v_middle, dimname=nv_middle_dim)
  call cdf_define(ncid, vn_vl_middle, vl_middle, dimname=nvl_middle_dim)
  call cdf_define(ncid, vn_u_outer, u_outer, dimname=nu_outer_dim)
  call cdf_define(ncid, vn_v_outer, v_outer, dimname=nv_outer_dim)
  call cdf_define(ncid, vn_vl_outer, vl_outer, dimname=nvl_outer_dim)
  call cdf_define(ncid, vn_xm_plasma, xm_plasma, dimname=mnmax_plasma_dim)
  call cdf_define(ncid, vn_xn_plasma, xn_plasma, dimname=mnmax_plasma_dim)
  call cdf_define(ncid, vn_xm_middle, xm_middle, dimname=mnmax_middle_dim)
  call cdf_define(ncid, vn_xn_middle, xn_middle, dimname=mnmax_middle_dim)
  call cdf_define(ncid, vn_xm_outer, xm_outer, dimname=mnmax_outer_dim)
  call cdf_define(ncid, vn_xn_outer, xn_outer, dimname=mnmax_outer_dim)
  call cdf_define(ncid, vn_svd_s_inductance_plasma, svd_s_inductance_plasma, dimname=n_singular_values_inductance_plasma_dim)
  call cdf_define(ncid, vn_svd_s_inductance_middle, svd_s_inductance_middle, dimname=n_singular_values_inductance_middle_dim)
  call cdf_define(ncid, vn_pseudoinverse_thresholds, &
       pseudoinverse_thresholds(1:n_pseudoinverse_thresholds), dimname=n_pseudoinverse_thresholds_dim)
  call cdf_define(ncid, vn_n_singular_values_retained, n_singular_values_retained, dimname=n_pseudoinverse_thresholds_dim)

  ! Arrays with dimension 2

  call cdf_define(ncid, vn_norm_normal_plasma,  norm_normal_plasma,  dimname=u_vl_plasma_dim)
  call cdf_define(ncid, vn_norm_normal_middle,  norm_normal_middle,  dimname=u_vl_middle_dim)
  call cdf_define(ncid, vn_norm_normal_outer,  norm_normal_outer,  dimname=u_vl_outer_dim)
  if (save_level<1) then
     call cdf_define(ncid, vn_inductance_plasma, inductance_plasma, dimname=basis_plasma_outer_dim)
     call cdf_define(ncid, vn_inductance_middle, inductance_middle, dimname=basis_middle_outer_dim)
  end if
  call cdf_define(ncid, vn_svd_s_transferMatrix, svd_s_transferMatrix, dimname=n_singular_values_thresholds_dim)

  ! Arrays with dimension 3

  call cdf_define(ncid, vn_r_plasma,  r_plasma,  dimname=u_vl_xyz_plasma_dim)
  call cdf_define(ncid, vn_r_middle,  r_middle,  dimname=u_vl_xyz_middle_dim)
  call cdf_define(ncid, vn_r_outer, r_outer, dimname=u_vl_xyz_outer_dim)

  call cdf_define(ncid, vn_drdu_plasma,  drdu_plasma,  dimname=u_vl_xyz_plasma_dim)
  call cdf_define(ncid, vn_drdu_middle,  drdu_middle,  dimname=u_vl_xyz_middle_dim)
  call cdf_define(ncid, vn_drdu_outer, drdu_outer, dimname=u_vl_xyz_outer_dim)

  call cdf_define(ncid, vn_drdv_plasma,  drdv_plasma,  dimname=u_vl_xyz_plasma_dim)
  call cdf_define(ncid, vn_drdv_middle,  drdv_middle,  dimname=u_vl_xyz_middle_dim)
  call cdf_define(ncid, vn_drdv_outer, drdv_outer, dimname=u_vl_xyz_outer_dim)

  call cdf_define(ncid, vn_normal_plasma,  normal_plasma,  dimname=u_vl_xyz_plasma_dim)
  call cdf_define(ncid, vn_normal_middle,  normal_middle,  dimname=u_vl_xyz_middle_dim)
  call cdf_define(ncid, vn_normal_outer, normal_outer, dimname=u_vl_xyz_outer_dim)
  call cdf_define(ncid, vn_svd_u_transferMatrix_sin, svd_u_transferMatrix_sin, dimname=mnmax_plasma_nsave_thresholds_dim)
  call cdf_define(ncid, vn_svd_u_transferMatrix_cos, svd_u_transferMatrix_cos, dimname=mnmax_plasma_nsave_thresholds_dim)
  call cdf_define(ncid, vn_svd_v_transferMatrix_sin, svd_v_transferMatrix_sin, dimname=mnmax_middle_nsave_thresholds_dim)
  call cdf_define(ncid, vn_svd_v_transferMatrix_cos, svd_v_transferMatrix_cos, dimname=mnmax_middle_nsave_thresholds_dim)

  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!1
  ! Done with cdf_define calls. Now write the data.
  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!1

  ! Scalars

  call cdf_write(ncid, vn_nfp, nfp)
  call cdf_write(ncid, vn_geometry_option_plasma, geometry_option_plasma)
  call cdf_write(ncid, vn_geometry_option_middle, geometry_option_middle)
  call cdf_write(ncid, vn_geometry_option_outer, geometry_option_outer)
  call cdf_write(ncid, vn_nu_plasma, nu_plasma)
  call cdf_write(ncid, vn_nv_plasma, nv_plasma)
  call cdf_write(ncid, vn_nvl_plasma, nvl_plasma)
  call cdf_write(ncid, vn_nu_middle, nu_middle)
  call cdf_write(ncid, vn_nv_middle, nv_middle)
  call cdf_write(ncid, vn_nvl_middle, nvl_middle)
  call cdf_write(ncid, vn_nu_outer, nu_outer)
  call cdf_write(ncid, vn_nv_outer, nv_outer)
  call cdf_write(ncid, vn_nvl_outer, nvl_outer)
  call cdf_write(ncid, vn_mpol_plasma, mpol_plasma)
  call cdf_write(ncid, vn_ntor_plasma, ntor_plasma)
  call cdf_write(ncid, vn_mnmax_plasma, mnmax_plasma)
  call cdf_write(ncid, vn_num_basis_functions_plasma, num_basis_functions_plasma)
  call cdf_write(ncid, vn_mpol_middle, mpol_middle)
  call cdf_write(ncid, vn_ntor_middle, ntor_middle)
  call cdf_write(ncid, vn_mnmax_middle, mnmax_middle)
  call cdf_write(ncid, vn_num_basis_functions_middle, num_basis_functions_middle)
  call cdf_write(ncid, vn_mpol_outer, mpol_outer)
  call cdf_write(ncid, vn_ntor_outer, ntor_outer)
  call cdf_write(ncid, vn_mnmax_outer, mnmax_outer)
  call cdf_write(ncid, vn_num_basis_functions_outer, num_basis_functions_outer)
  call cdf_write(ncid, vn_basis_set_option, basis_set_option)
  call cdf_write(ncid, vn_n_singular_values_inductance_plasma, n_singular_values_inductance_plasma)
  call cdf_write(ncid, vn_n_singular_values_inductance_middle, n_singular_values_inductance_middle)
  call cdf_write(ncid, vn_n_pseudoinverse_thresholds, n_pseudoinverse_thresholds)
  call cdf_write(ncid, vn_n_singular_vectors_to_save, n_singular_vectors_to_save)
  call cdf_write(ncid, vn_totalTime, totalTime)

  ! Arrays with dimension 1

  call cdf_write(ncid, vn_u_plasma, u_plasma)
  call cdf_write(ncid, vn_v_plasma, v_plasma)
  call cdf_write(ncid, vn_vl_plasma, vl_plasma)
  call cdf_write(ncid, vn_u_middle, u_middle)
  call cdf_write(ncid, vn_v_middle, v_middle)
  call cdf_write(ncid, vn_vl_middle, vl_middle)
  call cdf_write(ncid, vn_u_outer, u_outer)
  call cdf_write(ncid, vn_v_outer, v_outer)
  call cdf_write(ncid, vn_vl_outer, vl_outer)
  call cdf_write(ncid, vn_xm_plasma, xm_plasma)
  call cdf_write(ncid, vn_xn_plasma, xn_plasma)
  call cdf_write(ncid, vn_xm_middle, xm_middle)
  call cdf_write(ncid, vn_xn_middle, xn_middle)
  call cdf_write(ncid, vn_xm_outer, xm_outer)
  call cdf_write(ncid, vn_xn_outer, xn_outer)
  call cdf_write(ncid, vn_svd_s_inductance_plasma, svd_s_inductance_plasma)
  call cdf_write(ncid, vn_svd_s_inductance_middle, svd_s_inductance_middle)
  call cdf_write(ncid, vn_pseudoinverse_thresholds, &
       pseudoinverse_thresholds(1:n_pseudoinverse_thresholds))
  call cdf_write(ncid, vn_n_singular_values_retained, n_singular_values_retained)

  ! Arrays with dimension 2

  call cdf_write(ncid, vn_norm_normal_plasma,  norm_normal_plasma)
  call cdf_write(ncid, vn_norm_normal_middle,  norm_normal_middle)
  call cdf_write(ncid, vn_norm_normal_outer,  norm_normal_outer)
  if (save_level<1) then
     call cdf_write(ncid, vn_inductance_plasma, inductance_plasma)
     call cdf_write(ncid, vn_inductance_middle, inductance_middle)
  end if
  call cdf_write(ncid, vn_svd_s_transferMatrix, svd_s_transferMatrix)

  ! Arrays with dimension 3

  call cdf_write(ncid, vn_r_plasma, r_plasma)
  call cdf_write(ncid, vn_r_middle, r_middle)
  call cdf_write(ncid, vn_r_outer,  r_outer)

  call cdf_write(ncid, vn_drdu_plasma, drdu_plasma)
  call cdf_write(ncid, vn_drdu_middle, drdu_middle)
  call cdf_write(ncid, vn_drdu_outer,  drdu_outer)

  call cdf_write(ncid, vn_drdv_plasma, drdv_plasma)
  call cdf_write(ncid, vn_drdv_middle, drdv_middle)
  call cdf_write(ncid, vn_drdv_outer,  drdv_outer)

  call cdf_write(ncid, vn_normal_plasma, normal_plasma)
  call cdf_write(ncid, vn_normal_middle, normal_middle)
  call cdf_write(ncid, vn_normal_outer,  normal_outer)

  call cdf_write(ncid, vn_svd_u_transferMatrix_sin, svd_u_transferMatrix_sin)
  call cdf_write(ncid, vn_svd_u_transferMatrix_cos, svd_u_transferMatrix_cos)
  call cdf_write(ncid, vn_svd_v_transferMatrix_sin, svd_v_transferMatrix_sin)
  call cdf_write(ncid, vn_svd_v_transferMatrix_cos, svd_v_transferMatrix_cos)


  ! Finish up:
  call cdf_close(ncid)

end subroutine writeOutput
