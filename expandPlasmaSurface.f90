subroutine expandPlasmaSurface(u, v, separation, x,y,z)
  
  use read_wout_mod, only: nfp, ns, xm, xn, mnmax, rmnc, zmns
  use stel_kinds
  use stel_constants

  implicit none

  real(dp), intent(in) :: u,v,separation
  real(dp), intent(out) :: x,y,z

  integer :: imn
  real(dp) :: dxdu, dxdv, dydu, dydv, dzdu, dzdv
  real(dp) :: angle, sinangle, cosangle
  real(dp) :: dsinangledu, dsinangledv, dcosangledu, dcosangledv
  real(dp) :: phi, sinphi, cosphi
  real(dp) :: dsinphidv, dcosphidv
  real(dp) :: normal_x, normal_y, normal_z, normal_abs

  x=0
  y=0
  z=0
  dxdu=0
  dydu=0
  dzdu=0
  dxdv=0
  dydv=0
  dzdv=0

  phi = twopi*v/nfp
  sinphi = sin(phi)
  cosphi = cos(phi)
  dsinphidv = cosphi*twopi/nfp
  dcosphidv = -sinphi*twopi/nfp

  do imn = 1,mnmax
     angle = twopi*(xm(imn)*u + xn(imn)*v/nfp)
     cosangle = cos(angle)
     sinangle = sin(angle)
     dsinangledu = cosangle*twopi*xm(imn)
     dcosangledu = -sinangle*twopi*xm(imn)
     dsinangledv = cosangle*twopi*xn(imn)/nfp
     dcosangledv = -sinangle*twopi*xn(imn)/nfp

     x = x + rmnc(imn,ns) * cosangle * cosphi
     y = y + rmnc(imn,ns) * cosangle * sinphi
     z = z + zmns(imn,ns) * sinangle
     
     dxdu = dxdu + rmnc(imn,ns) * dcosangledu * cosphi
     dydu = dydu + rmnc(imn,ns) * dcosangledu * sinphi
     dzdu = dzdu + zmns(imn,ns) * dsinangledu
     
     dxdv = dxdv + rmnc(imn,ns) * (dcosangledv * cosphi + cosangle * dcosphidv)
     dydv = dydv + rmnc(imn,ns) * (dcosangledv * sinphi + cosangle * dsinphidv)
     dzdv = dzdv + zmns(imn,ns) * dsinangledv
     
  end do

  ! Evaluate the (non-unit-magnitude) surface normal vector from N = (dr/dv) cross (dr/du):
  normal_x = dydv * dzdu - dydu * dzdv
  normal_y = dzdv * dxdu - dzdu * dxdv
  normal_z = dxdv * dydu - dxdu * dydv

  ! Now normalize the normal vector so it has unit magnitude:
  normal_abs = sqrt(normal_x*normal_x + normal_y*normal_y + normal_z*normal_z)
  normal_x = normal_x / normal_abs
  normal_y = normal_y / normal_abs
  normal_z = normal_z / normal_abs

  ! Move in the normal direction away from the plasma surface:
  x = x + normal_x * separation
  y = y + normal_y * separation
  z = z + normal_z * separation

end subroutine expandPlasmaSurface
