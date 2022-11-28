# Fidelity Pointwise V18.6R2 Journal file 
# Create standalone tower mesh with top round and constant z=0 extrusion at ground
# v0.1 
# Created by Nate deVelder, SNL, 11/28/2022

package require PWI_Glyph 6.22.1

pw::Application setUndoMaximumLevels 8
pw::Application reset
pw::Application markUndoLevel {Journal Reset}

pw::Application clearModified

# Geometric params
set botRadius 3.0
set topRadius 1.935
set towerHeight 88.6
set filletRad 1.0

# Calc fillet params
set fullHeight [expr {$towerHeight + $filletRad}]
set fullRad [expr {$topRadius - $filletRad}]

# Mesh Params
set defaultN 25 
set towerSpanN 165
set capN 13
set filletN 19

# Extrusion Params
set extrusionLevels 66
set initStep 2.0e-5 
set growthFactor 1.2
set expSmooth 0.7
set impSmooth 1.4
set kbSmooth 0.2
set volCoeff 0.7

# CAE Export
set fileExportLoc "/gpfs/ndeveld/hfm/tower_mesh_bottom_zero/tower-mesh-new.exo"

# Make base points
set _DB(1) [pw::Point create]
$_DB(1) setPoint {0 0 0}
set _DB(2) [pw::Point create]
$_DB(2) setPoint [list $botRadius 0 0]
pw::Application markUndoLevel {Create Point}

# Make base circle
set _TMP(mode_1) [pw::Application begin Create]
  pw::Display resetView +Z
  set _TMP(PW_1) [pw::SegmentCircle create]
  $_TMP(PW_1) addPoint [list 0 0 $_DB(2)]
  $_TMP(PW_1) addPoint [list 0 0 $_DB(1)]
  $_TMP(PW_1) setEndAngle 360 {0 0 -1}
  set _DB(3) [pw::Curve create]
  $_DB(3) addSegment $_TMP(PW_1)
  unset _TMP(PW_1)
$_TMP(mode_1) end
unset _TMP(mode_1)
pw::Application markUndoLevel {Create Curve}

# Split Base
set _TMP(split_params) [list]
lappend _TMP(split_params) [$_DB(3) getParameter -arc 0.25]
lappend _TMP(split_params) [$_DB(3) getParameter -arc 0.5]
lappend _TMP(split_params) [$_DB(3) getParameter -arc 0.75]
set _TMP(PW_1) [$_DB(3) split $_TMP(split_params)]
unset _TMP(PW_1)
unset _TMP(split_params)
pw::Application markUndoLevel Split

# Create points on split
set _DB(4) [pw::DatabaseEntity getByName curve-1-split-4]
set _DB(5) [pw::DatabaseEntity getByName curve-1-split-3]
set _DB(6) [pw::DatabaseEntity getByName curve-1-split-2]
set _DB(7) [pw::DatabaseEntity getByName curve-1-split-1]
set _DB(8) [pw::Point create]

$_DB(8) setPoint [list 0 0 $_DB(4)]
set _DB(9) [pw::Point create]
$_DB(9) setPoint [list 0 0 $_DB(5)]
set _DB(10) [pw::Point create]
$_DB(10) setPoint [list 1 0 $_DB(7)]
pw::Application markUndoLevel {Create Point}

# Create points for top
set _DB(11) [pw::Point create]
$_DB(11) setPoint [list 0 0 $towerHeight]
set _DB(12) [pw::Point create]
$_DB(12) setPoint [list $topRadius 0 $towerHeight]
pw::Application markUndoLevel {Create Point}

# Create circle for top
set _TMP(mode_1) [pw::Application begin Create]
  pw::Display resetView +Z
  set _TMP(PW_1) [pw::SegmentCircle create]
  $_TMP(PW_1) addPoint [list 0 0 $_DB(12)]
  $_TMP(PW_1) addPoint [list 0 0 $_DB(11)]
  $_TMP(PW_1) setEndAngle 360 {0 0 -1}
  set _DB(13) [pw::Curve create]
  $_DB(13) addSegment $_TMP(PW_1)
  unset _TMP(PW_1)
$_TMP(mode_1) end
unset _TMP(mode_1)
pw::Application markUndoLevel {Create Curve}

# Split top circle
set _TMP(split_params) [list]
lappend _TMP(split_params) [$_DB(13) getParameter -arc 0.25]
lappend _TMP(split_params) [$_DB(13) getParameter -arc 0.5]
lappend _TMP(split_params) [$_DB(13) getParameter -arc 0.75]
set _TMP(PW_1) [$_DB(13) split $_TMP(split_params)]
unset _TMP(PW_1)
unset _TMP(split_params)
pw::Application markUndoLevel Split

# Create points top circle
set _DB(14) [pw::DatabaseEntity getByName curve-1-split-5]
set _DB(15) [pw::DatabaseEntity getByName curve-1-split-6]
set _DB(16) [pw::DatabaseEntity getByName curve-1-split-7]
set _DB(17) [pw::DatabaseEntity getByName curve-1-split-8]
set _DB(18) [pw::Point create]
$_DB(18) setPoint [list 1 0 $_DB(14)]
set _DB(19) [pw::Point create]
$_DB(19) setPoint [list 1 0 $_DB(15)]
set _DB(20) [pw::Point create]
$_DB(20) setPoint [list 1 0 $_DB(16)]
pw::Application markUndoLevel {Create Point}

# Connect circles 
set _TMP(mode_1) [pw::Application begin Create]
  set _TMP(PW_1) [pw::SegmentSpline create]
  $_TMP(PW_1) addPoint [list 0 0 $_DB(9)]
  $_TMP(PW_1) addPoint [list 0 0 $_DB(19)]
  set _DB(21) [pw::Curve create]
  $_DB(21) addSegment $_TMP(PW_1)
  unset _TMP(PW_1)
$_TMP(mode_1) end
unset _TMP(mode_1)
pw::Application markUndoLevel {Create 2 Point Curve}

set _TMP(mode_1) [pw::Application begin Create]
  set _TMP(PW_1) [pw::SegmentSpline create]
  $_TMP(PW_1) addPoint [list 0 0 $_DB(8)]
  $_TMP(PW_1) addPoint [list 0 0 $_DB(20)]
  set _DB(22) [pw::Curve create]
  $_DB(22) addSegment $_TMP(PW_1)
  unset _TMP(PW_1)
$_TMP(mode_1) end
unset _TMP(mode_1)
pw::Application markUndoLevel {Create 2 Point Curve}

set _TMP(mode_1) [pw::Application begin Create]
  set _TMP(PW_1) [pw::SegmentSpline create]
  $_TMP(PW_1) addPoint [list 0 0 $_DB(2)]
  $_TMP(PW_1) addPoint [list 0 0 $_DB(12)]
  set _DB(23) [pw::Curve create]
  $_DB(23) addSegment $_TMP(PW_1)
  unset _TMP(PW_1)
$_TMP(mode_1) end
unset _TMP(mode_1)
pw::Application markUndoLevel {Create 2 Point Curve}

set _TMP(mode_1) [pw::Application begin Create]
  set _TMP(PW_1) [pw::SegmentSpline create]
  $_TMP(PW_1) addPoint [list 0 0 $_DB(10)]
  $_TMP(PW_1) addPoint [list 0 0 $_DB(18)]
  set _DB(24) [pw::Curve create]
  $_DB(24) addSegment $_TMP(PW_1)
  unset _TMP(PW_1)
$_TMP(mode_1) end
unset _TMP(mode_1)
pw::Application markUndoLevel {Create 2 Point Curve}

# Create fillet circle points
set _DB(25) [pw::Point create]
$_DB(25) setPoint [list 0 -$fullRad $fullHeight]
set _DB(26) [pw::Point create]
$_DB(26) setPoint [list 0 0 $fullHeight]
pw::Application markUndoLevel {Create Point}

# Create fillet circle
set _TMP(mode_1) [pw::Application begin Create]
  set _TMP(PW_1) [pw::SegmentCircle create]
  pw::Display resetView -Z
  $_TMP(PW_1) addPoint [list 0 0 $_DB(25)]
  $_TMP(PW_1) addPoint [list 0 0 $_DB(26)]
  $_TMP(PW_1) setEndAngle 360 {0 0 1}
  set _DB(27) [pw::Curve create]
  $_DB(27) addSegment $_TMP(PW_1)
  unset _TMP(PW_1)
$_TMP(mode_1) end
unset _TMP(mode_1)
pw::Application markUndoLevel {Create Curve}

# Split fillet circle
pw::Display resetView +X
set _TMP(split_params) [list]
lappend _TMP(split_params) [$_DB(27) getParameter -arc 0.25]
lappend _TMP(split_params) [$_DB(27) getParameter -arc 0.5]
lappend _TMP(split_params) [$_DB(27) getParameter -arc 0.75]
set _TMP(PW_1) [$_DB(27) split $_TMP(split_params)]
unset _TMP(PW_1)
unset _TMP(split_params)
pw::Application markUndoLevel Split

# Add points to fillet circle
set _DB(28) [pw::DatabaseEntity getByName curve-5-split-4]
set _DB(29) [pw::DatabaseEntity getByName curve-5-split-3]
set _DB(30) [pw::DatabaseEntity getByName curve-5-split-2]
set _DB(31) [pw::DatabaseEntity getByName curve-5-split-1]
set _DB(32) [pw::Point create]
$_DB(32) setPoint [list 0 0 $_DB(28)]
set _DB(33) [pw::Point create]
$_DB(33) setPoint [list 0 0 $_DB(29)]
set _DB(34) [pw::Point create]
$_DB(34) setPoint [list 1 0 $_DB(31)]
pw::Application markUndoLevel {Create Point}

# Delete circle contruction points
pw::Entity delete [list $_DB(11) $_DB(26) $_DB(1)]
pw::Application markUndoLevel Delete

set _TMP(mode_1) [pw::Application begin Create]
  set _TMP(PW_1) [pw::SegmentSpline create]
  set _DB(1) [pw::DatabaseEntity getByName point-14]
  set _DB(2) [pw::DatabaseEntity getByName curve-5-split-3]
  set _DB(3) [pw::DatabaseEntity getByName curve-5-split-2]
  set _DB(4) [pw::DatabaseEntity getByName point-11]
  set _DB(5) [pw::DatabaseEntity getByName curve-5-split-4]
  set _DB(6) [pw::DatabaseEntity getByName curve-5-split-1]
  $_TMP(PW_1) addPoint [list 0 0 $_DB(1)]
  $_TMP(PW_1) addPoint [list 0 0 $_DB(4)]
  set _CN(1) [pw::Connector create]
  $_CN(1) addSegment $_TMP(PW_1)
  unset _TMP(PW_1)
  $_CN(1) calculateDimension
$_TMP(mode_1) end
unset _TMP(mode_1)
pw::Application markUndoLevel {Create 2 Point Connector}

set _TMP(mode_1) [pw::Application begin Create]
  set _TMP(PW_1) [pw::SegmentSpline create]
  $_TMP(PW_1) delete
  unset _TMP(PW_1)
$_TMP(mode_1) abort
unset _TMP(mode_1)
$_CN(1) delete
pw::Application markUndoLevel {Delete Last Curve}

set _TMP(mode_1) [pw::Application begin Create]
  set _TMP(PW_1) [pw::SegmentSpline create]
  $_TMP(PW_1) addPoint [list 0 0 $_DB(1)]
  $_TMP(PW_1) addPoint [list 0 0 $_DB(4)]
  set _DB(7) [pw::Curve create]
  $_DB(7) addSegment $_TMP(PW_1)
  unset _TMP(PW_1)
$_TMP(mode_1) end
unset _TMP(mode_1)
pw::Application markUndoLevel {Create 2 Point Curve}

set _TMP(mode_1) [pw::Application begin Create]
  set _TMP(PW_1) [pw::SegmentSpline create]
  set _DB(8) [pw::DatabaseEntity getByName point-13]
  set _DB(9) [pw::DatabaseEntity getByName point-15]
  $_TMP(PW_1) addPoint [list 0 0 $_DB(8)]
  $_TMP(PW_1) addPoint [list 0 0 $_DB(9)]
  set _DB(10) [pw::Curve create]
  $_DB(10) addSegment $_TMP(PW_1)
  unset _TMP(PW_1)
$_TMP(mode_1) end
unset _TMP(mode_1)
pw::Application markUndoLevel {Create 2 Point Curve}

set _TMP(mode_1) [pw::Application begin Create]
  set _TMP(PW_1) [pw::SegmentSpline create]
  $_TMP(PW_1) delete
  unset _TMP(PW_1)
$_TMP(mode_1) abort
unset _TMP(mode_1)
set _TMP(split_params) [list]
lappend _TMP(split_params) [$_DB(10) getParameter -arc 0.25]
lappend _TMP(split_params) [$_DB(10) getParameter -arc 0.5]
lappend _TMP(split_params) [$_DB(10) getParameter -arc 0.75]
set _TMP(PW_1) [$_DB(10) split $_TMP(split_params)]
unset _TMP(PW_1)
unset _TMP(split_params)
pw::Application markUndoLevel Split

set _TMP(split_params) [list]
lappend _TMP(split_params) [$_DB(7) getParameter -arc 0.25]
lappend _TMP(split_params) [$_DB(7) getParameter -arc 0.5]
lappend _TMP(split_params) [$_DB(7) getParameter -arc 0.75]
set _TMP(PW_1) [$_DB(7) split $_TMP(split_params)]
unset _TMP(PW_1)
unset _TMP(split_params)
pw::Application markUndoLevel Split

set _DB(11) [pw::DatabaseEntity getByName curve-6-split-2]
set _DB(12) [pw::DatabaseEntity getByName curve-6-split-3]
set _DB(13) [pw::DatabaseEntity getByName curve-5-split-6]
set _DB(14) [pw::DatabaseEntity getByName curve-5-split-7]
pw::Entity delete [list $_DB(11) $_DB(12) $_DB(13) $_DB(14)]
pw::Application markUndoLevel Delete

set _DB(15) [pw::DatabaseEntity getByName curve-6-split-1]
set _DB(16) [pw::DatabaseEntity getByName curve-5-split-5]
set _DB(17) [pw::DatabaseEntity getByName curve-6-split-4]
set _DB(18) [pw::DatabaseEntity getByName curve-5-split-8]
set _DB(19) [pw::Point create]
$_DB(19) setPoint [list 1 0 $_DB(15)]
set _DB(20) [pw::Point create]
$_DB(20) setPoint [list 1 0 $_DB(16)]
set _DB(21) [pw::Point create]
$_DB(21) setPoint [list 0 0 $_DB(17)]
set _DB(22) [pw::Point create]
$_DB(22) setPoint [list 0 0 $_DB(18)]
pw::Application markUndoLevel {Create Point}

set _TMP(mode_1) [pw::Application begin Create]
  set _TMP(PW_1) [pw::SegmentSpline create]
  $_TMP(PW_1) addPoint [list 0 0 $_DB(19)]
  $_TMP(PW_1) addPoint [list 0 0 $_DB(20)]
  set _DB(23) [pw::Curve create]
  $_DB(23) addSegment $_TMP(PW_1)
  unset _TMP(PW_1)
$_TMP(mode_1) end
unset _TMP(mode_1)
pw::Application markUndoLevel {Create 2 Point Curve}

set _TMP(mode_1) [pw::Application begin Create]
  set _TMP(PW_1) [pw::SegmentSpline create]
  $_TMP(PW_1) addPoint [list 0 0 $_DB(20)]
  $_TMP(PW_1) addPoint [list 0 0 $_DB(21)]
  set _DB(24) [pw::Curve create]
  $_DB(24) addSegment $_TMP(PW_1)
  unset _TMP(PW_1)
$_TMP(mode_1) end
unset _TMP(mode_1)
pw::Application markUndoLevel {Create 2 Point Curve}

set _TMP(mode_1) [pw::Application begin Create]
  set _TMP(PW_1) [pw::SegmentSpline create]
  $_TMP(PW_1) addPoint [list 0 0 $_DB(21)]
  $_TMP(PW_1) addPoint [list 0 0 $_DB(22)]
  set _DB(25) [pw::Curve create]
  $_DB(25) addSegment $_TMP(PW_1)
  unset _TMP(PW_1)
$_TMP(mode_1) end
unset _TMP(mode_1)
pw::Application markUndoLevel {Create 2 Point Curve}

set _TMP(mode_1) [pw::Application begin Create]
  set _TMP(PW_1) [pw::SegmentSpline create]
  $_TMP(PW_1) addPoint [list 0 0 $_DB(22)]
  $_TMP(PW_1) addPoint [list 0 0 $_DB(19)]
  set _DB(26) [pw::Curve create]
  $_DB(26) addSegment $_TMP(PW_1)
  unset _TMP(PW_1)
$_TMP(mode_1) end
unset _TMP(mode_1)
pw::Application markUndoLevel {Create 2 Point Curve}

set _TMP(mode_1) [pw::Application begin Create]
  set _TMP(PW_1) [pw::SegmentSpline create]
  $_TMP(PW_1) delete
  unset _TMP(PW_1)
$_TMP(mode_1) abort
unset _TMP(mode_1)

set _TMP(mode_1) [pw::Application begin Create]
  set _TMP(PW_1) [pw::SegmentConic create]
  set _DB(1) [pw::DatabaseEntity getByName point-8]
  set _DB(2) [pw::DatabaseEntity getByName curve-1-split-6]
  set _DB(3) [pw::DatabaseEntity getByName curve-4]
  set _DB(4) [pw::DatabaseEntity getByName curve-1-split-5]
  set _DB(5) [pw::DatabaseEntity getByName point-11]
  set _DB(6) [pw::DatabaseEntity getByName curve-5-split-4]
  set _DB(7) [pw::DatabaseEntity getByName curve-5-split-1]
  set _DB(8) [pw::DatabaseEntity getByName curve-5-split-8]
  $_TMP(PW_1) addPoint [list 0 0 $_DB(1)]
  $_TMP(PW_1) addPoint [list 0 0 $_DB(5)]
  $_TMP(PW_1) setIntersectPoint [pwu::Vector3 intersect [pw::Application getXYZ [list 1 0 $_DB(3)]] [$_DB(3) getTangent -arc 1] [pw::Application getXYZ [list 1 0 $_DB(8)]] [$_DB(8) getTangent -arc 1]]
  set _DB(9) [pw::Curve create]
  $_DB(9) addSegment $_TMP(PW_1)
  unset _TMP(PW_1)
$_TMP(mode_1) end
unset _TMP(mode_1)
pw::Application markUndoLevel {Create Curve}

set _TMP(mode_1) [pw::Application begin Create]
  set _TMP(PW_1) [pw::SegmentConic create]
  set _DB(10) [pw::DatabaseEntity getByName point-10]
  set _DB(11) [pw::DatabaseEntity getByName curve-1-split-7]
  set _DB(12) [pw::DatabaseEntity getByName curve-1-split-8]
  set _DB(13) [pw::DatabaseEntity getByName curve-2]
  set _DB(14) [pw::DatabaseEntity getByName point-14]
  set _DB(15) [pw::DatabaseEntity getByName curve-5-split-3]
  set _DB(16) [pw::DatabaseEntity getByName curve-5-split-5]
  set _DB(17) [pw::DatabaseEntity getByName curve-5-split-2]
  $_TMP(PW_1) addPoint [list 0 0 $_DB(10)]
  $_TMP(PW_1) addPoint [list 0 0 $_DB(14)]
  $_TMP(PW_1) setIntersectPoint [pwu::Vector3 intersect [pw::Application getXYZ [list 1 0 $_DB(13)]] [$_DB(13) getTangent -arc 1] [pw::Application getXYZ [list 0 0 $_DB(16)]] [$_DB(16) getTangent -arc 0]]
  set _DB(18) [pw::Curve create]
  $_DB(18) addSegment $_TMP(PW_1)
  unset _TMP(PW_1)
$_TMP(mode_1) end
unset _TMP(mode_1)
pw::Application markUndoLevel {Create Curve}

pw::Display resetView +Y
set _TMP(mode_1) [pw::Application begin Create]
  set _TMP(PW_1) [pw::SegmentConic create]
  set _DB(19) [pw::DatabaseEntity getByName point-9]
  set _DB(20) [pw::DatabaseEntity getByName curve-1]
  set _DB(21) [pw::DatabaseEntity getByName point-13]
  set _DB(22) [pw::DatabaseEntity getByName curve-6-split-1]
  set _DB(23) [pw::DatabaseEntity getByName point-15]
  set _DB(24) [pw::DatabaseEntity getByName curve-6-split-4]
  $_TMP(PW_1) addPoint [list 0 0 $_DB(19)]
  $_TMP(PW_1) addPoint [list 0 0 $_DB(21)]
  $_TMP(PW_1) setIntersectPoint [pwu::Vector3 intersect [pw::Application getXYZ [list 1 0 $_DB(20)]] [$_DB(20) getTangent -arc 1] [pw::Application getXYZ [list 0 0 $_DB(22)]] [$_DB(22) getTangent -arc 0]]
  set _DB(25) [pw::Curve create]
  $_DB(25) addSegment $_TMP(PW_1)
  unset _TMP(PW_1)
$_TMP(mode_1) end
unset _TMP(mode_1)
pw::Application markUndoLevel {Create Curve}

set _TMP(mode_1) [pw::Application begin Create]
  set _TMP(PW_1) [pw::SegmentConic create]
  set _DB(26) [pw::DatabaseEntity getByName point-7]
  set _DB(27) [pw::DatabaseEntity getByName curve-3]
  $_TMP(PW_1) addPoint [list 0 0 $_DB(23)]
  $_TMP(PW_1) addPoint [list 0 0 $_DB(26)]
  $_TMP(PW_1) setIntersectPoint [pwu::Vector3 intersect [pw::Application getXYZ [list 1 0 $_DB(27)]] [$_DB(27) getTangent -arc 1] [pw::Application getXYZ [list 1 0 $_DB(24)]] [$_DB(24) getTangent -arc 1]]
  set _DB(28) [pw::Curve create]
  $_DB(28) addSegment $_TMP(PW_1)
  unset _TMP(PW_1)
$_TMP(mode_1) end
unset _TMP(mode_1)
pw::Application markUndoLevel {Create Curve}

set _TMP(mode_1) [pw::Application begin Create]
  set _TMP(PW_1) [pw::SegmentConic create]
  $_TMP(PW_1) delete
  unset _TMP(PW_1)
$_TMP(mode_1) abort
unset _TMP(mode_1)


##################################
## Start Surfaces
##################################


set _DB(1) [pw::DatabaseEntity getByName curve-7]
set _DB(2) [pw::DatabaseEntity getByName curve-5-split-2]
set _DB(3) [pw::DatabaseEntity getByName curve-5-split-1]
set _DB(4) [pw::DatabaseEntity getByName curve-6-split-1]
set _DB(5) [pw::DatabaseEntity getByName curve-5-split-4]
set _DB(6) [pw::DatabaseEntity getByName curve-5]
set _DB(7) [pw::DatabaseEntity getByName curve-5-split-3]
set _DB(8) [pw::DatabaseEntity getByName curve-6-split-4]
set _DB(9) [pw::DatabaseEntity getByName curve-5-split-5]
set _DB(10) [pw::DatabaseEntity getByName curve-5-split-8]
set _DB(11) [pw::DatabaseEntity getByName curve-6]
set _DB(12) [pw::DatabaseEntity getByName curve-8]
set _TMP(mode_1) [pw::Application begin SurfaceFit]
  set _TMP(surf_1) [$_TMP(mode_1) createSurfacesFromCurves [list $_DB(1) $_DB(2) $_DB(3) $_DB(4) $_DB(5) $_DB(6) $_DB(7) $_DB(8) $_DB(9) $_DB(10) $_DB(11) $_DB(12)]]
  $_TMP(mode_1) setBoundaryTolerance [pw::Database getFitTolerance]
  $_TMP(mode_1) setUseBoundaryTangency true
  $_TMP(mode_1) setTangencyEntities [list]
  unset _TMP(surf_1)
$_TMP(mode_1) end
unset _TMP(mode_1)
pw::Application markUndoLevel {Create Patch}

set _DB(13) [pw::DatabaseEntity getByName curve-1-split-5]
set _DB(14) [pw::DatabaseEntity getByName curve-1-split-1]
set _DB(15) [pw::DatabaseEntity getByName curve-3]
set _DB(16) [pw::DatabaseEntity getByName curve-4]
set _TMP(mode_1) [pw::Application begin SurfaceFit]
  set _TMP(surf_1) [$_TMP(mode_1) createSurfacesFromCurves [list $_DB(13) $_DB(14) $_DB(15) $_DB(16)]]
  set _DB(17) [pw::DatabaseEntity getByName curve-1]
  set _DB(18) [pw::DatabaseEntity getByName curve-1-split-6]
  set _DB(19) [pw::DatabaseEntity getByName curve-1-split-2]
  unset _TMP(surf_1)
$_TMP(mode_1) abort
unset _TMP(mode_1)
set _TMP(mode_1) [pw::Application begin SurfaceFit]
  set _TMP(surf_1) [$_TMP(mode_1) createSurfacesFromCurves [list $_DB(17) $_DB(18) $_DB(19) $_DB(16)]]
  $_TMP(mode_1) setBoundaryTolerance [pw::Database getFitTolerance]
  $_TMP(mode_1) setUseBoundaryTangency true
  $_TMP(mode_1) setTangencyEntities [list]
  unset _TMP(surf_1)
$_TMP(mode_1) end
unset _TMP(mode_1)
pw::Application markUndoLevel {Create Patch}

set _DB(20) [pw::DatabaseEntity getByName quilt-1]
set _DB(21) [pw::DatabaseEntity getByName point-13]
set _DB(22) [pw::DatabaseEntity getByName point-19]
set _DB(23) [pw::DatabaseEntity getByName curve-2]
set _DB(24) [pw::DatabaseEntity getByName quilt-5]
set _DB(25) [pw::DatabaseEntity getByName point-3]
set _DB(26) [pw::DatabaseEntity getByName point-9]
set _DB(27) [pw::DatabaseEntity getByName curve-1-split-8]
set _DB(28) [pw::DatabaseEntity getByName point-15]
set _DB(29) [pw::DatabaseEntity getByName point-14]
set _DB(30) [pw::DatabaseEntity getByName point-5]
set _DB(31) [pw::DatabaseEntity getByName point-4]
set _DB(32) [pw::DatabaseEntity getByName quilt-3]
set _DB(33) [pw::DatabaseEntity getByName point-11]
set _DB(34) [pw::DatabaseEntity getByName model-4]
set _DB(35) [pw::DatabaseEntity getByName model-1]
set _DB(36) [pw::DatabaseEntity getByName point-8]
set _DB(37) [pw::DatabaseEntity getByName point-10]
set _DB(38) [pw::DatabaseEntity getByName point-2]
set _DB(39) [pw::DatabaseEntity getByName curve-1-split-3]
set _DB(40) [pw::DatabaseEntity getByName curve-1-split-4]
set _DB(41) [pw::DatabaseEntity getByName point-7]
set _DB(42) [pw::DatabaseEntity getByName point-17]
set _DB(43) [pw::DatabaseEntity getByName curve-12]
set _DB(44) [pw::DatabaseEntity getByName point-18]
set _DB(45) [pw::DatabaseEntity getByName point-16]
set _DB(46) [pw::DatabaseEntity getByName curve-1-split-7]
set _DB(47) [pw::DatabaseEntity getByName quilt-2]
set _DB(48) [pw::DatabaseEntity getByName curve-9]
set _DB(49) [pw::DatabaseEntity getByName curve-10]
set _DB(50) [pw::DatabaseEntity getByName curve-11]
set _DB(51) [pw::DatabaseEntity getByName model-2]
set _DB(52) [pw::DatabaseEntity getByName quilt-4]
set _DB(53) [pw::DatabaseEntity getByName model-5]
set _DB(54) [pw::DatabaseEntity getByName model-3]
set _DB(55) [pw::DatabaseEntity getByName surface-6]
set _TMP(PW_1) [pw::Collection create]
$_TMP(PW_1) set [list $_DB(1) $_DB(2) $_DB(20) $_DB(21) $_DB(22) $_DB(23) $_DB(13) $_DB(24) $_DB(17) $_DB(25) $_DB(26) $_DB(27) $_DB(3) $_DB(18) $_DB(4) $_DB(28) $_DB(29) $_DB(30) $_DB(14) $_DB(31) $_DB(32) $_DB(33) $_DB(34) $_DB(35) $_DB(19) $_DB(5) $_DB(36) $_DB(37) $_DB(6) $_DB(15) $_DB(7) $_DB(38) $_DB(39) $_DB(40) $_DB(41) $_DB(42) $_DB(43) $_DB(16) $_DB(44) $_DB(8) $_DB(45) $_DB(46) $_DB(9) $_DB(10) $_DB(11) $_DB(47) $_DB(12) $_DB(48) $_DB(49) $_DB(50) $_DB(51) $_DB(52) $_DB(53) $_DB(54) $_DB(55)]
$_TMP(PW_1) do setRenderAttribute FillMode Shaded
$_TMP(PW_1) delete
unset _TMP(PW_1)
pw::Application markUndoLevel {Modify Entity Display}

set _TMP(mode_1) [pw::Application begin SurfaceFit]
  set _TMP(surf_1) [$_TMP(mode_1) createSurfacesFromCurves [list $_DB(13) $_DB(14) $_DB(15) $_DB(16)]]
  $_TMP(mode_1) setBoundaryTolerance [pw::Database getFitTolerance]
  $_TMP(mode_1) setUseBoundaryTangency true
  $_TMP(mode_1) setTangencyEntities [list]
  unset _TMP(surf_1)
$_TMP(mode_1) end
unset _TMP(mode_1)
pw::Application markUndoLevel {Create Patch}

set _TMP(PW_1) [pw::Collection create]
$_TMP(PW_1) set [list $_DB(13) $_DB(14) $_DB(15) $_DB(16)]
$_TMP(PW_1) do setRenderAttribute FillMode Shaded
$_TMP(PW_1) delete
unset _TMP(PW_1)
pw::Application markUndoLevel {Modify Entity Display}

set _DB(56) [pw::DatabaseEntity getByName surface-7]
set _TMP(PW_1) [pw::Collection create]
$_TMP(PW_1) set [list $_DB(1) $_DB(2) $_DB(20) $_DB(21) $_DB(22) $_DB(23) $_DB(13) $_DB(24) $_DB(17) $_DB(25) $_DB(26) $_DB(27) $_DB(3) $_DB(18) $_DB(4) $_DB(28) $_DB(29) $_DB(30) $_DB(14) $_DB(31) $_DB(32) $_DB(33) $_DB(34) $_DB(35) $_DB(19) $_DB(5) $_DB(36) $_DB(37) $_DB(6) $_DB(15) $_DB(7) $_DB(38) $_DB(39) $_DB(40) $_DB(41) $_DB(42) $_DB(43) $_DB(16) $_DB(44) $_DB(8) $_DB(45) $_DB(46) $_DB(9) $_DB(10) $_DB(11) $_DB(47) $_DB(12) $_DB(48) $_DB(49) $_DB(50) $_DB(51) $_DB(52) $_DB(53) $_DB(54) $_DB(55) $_DB(56)]
$_TMP(PW_1) do setRenderAttribute FillMode Shaded
$_TMP(PW_1) delete
unset _TMP(PW_1)
pw::Application markUndoLevel {Modify Entity Display}

set _TMP(mode_1) [pw::Application begin SurfaceFit]
  set _TMP(surf_1) [$_TMP(mode_1) createSurfacesFromCurves [list $_DB(23) $_DB(17) $_DB(39) $_DB(46)]]
  $_TMP(mode_1) setBoundaryTolerance [pw::Database getFitTolerance]
  $_TMP(mode_1) setUseBoundaryTangency true
  $_TMP(mode_1) setTangencyEntities [list]
  unset _TMP(surf_1)
$_TMP(mode_1) end
unset _TMP(mode_1)
pw::Application markUndoLevel {Create Patch}

set _DB(57) [pw::DatabaseEntity getByName surface-8]
set _TMP(PW_1) [pw::Collection create]
$_TMP(PW_1) set [list $_DB(1) $_DB(2) $_DB(20) $_DB(21) $_DB(22) $_DB(23) $_DB(13) $_DB(24) $_DB(17) $_DB(25) $_DB(26) $_DB(27) $_DB(3) $_DB(18) $_DB(4) $_DB(28) $_DB(29) $_DB(30) $_DB(14) $_DB(31) $_DB(32) $_DB(33) $_DB(34) $_DB(35) $_DB(19) $_DB(5) $_DB(36) $_DB(37) $_DB(6) $_DB(15) $_DB(7) $_DB(38) $_DB(39) $_DB(40) $_DB(41) $_DB(42) $_DB(43) $_DB(16) $_DB(44) $_DB(8) $_DB(45) $_DB(46) $_DB(9) $_DB(10) $_DB(11) $_DB(47) $_DB(12) $_DB(48) $_DB(49) $_DB(50) $_DB(51) $_DB(52) $_DB(53) $_DB(54) $_DB(55) $_DB(56) $_DB(57)]
$_TMP(PW_1) do setRenderAttribute FillMode Shaded
$_TMP(PW_1) delete
unset _TMP(PW_1)
pw::Application markUndoLevel {Modify Entity Display}

set _TMP(mode_1) [pw::Application begin SurfaceFit]
  set _TMP(surf_1) [$_TMP(mode_1) createSurfacesFromCurves [list $_DB(23) $_DB(27) $_DB(15) $_DB(40)]]
  $_TMP(mode_1) setBoundaryTolerance [pw::Database getFitTolerance]
  $_TMP(mode_1) setUseBoundaryTangency true
  $_TMP(mode_1) setTangencyEntities [list]
  unset _TMP(surf_1)
$_TMP(mode_1) end
unset _TMP(mode_1)
pw::Application markUndoLevel {Create Patch}

set _DB(58) [pw::DatabaseEntity getByName surface-9]
set _TMP(PW_1) [pw::Collection create]
$_TMP(PW_1) set [list $_DB(1) $_DB(2) $_DB(20) $_DB(21) $_DB(22) $_DB(23) $_DB(13) $_DB(24) $_DB(17) $_DB(25) $_DB(26) $_DB(27) $_DB(3) $_DB(18) $_DB(4) $_DB(28) $_DB(29) $_DB(30) $_DB(14) $_DB(31) $_DB(32) $_DB(33) $_DB(34) $_DB(35) $_DB(19) $_DB(5) $_DB(36) $_DB(37) $_DB(6) $_DB(15) $_DB(7) $_DB(38) $_DB(39) $_DB(40) $_DB(41) $_DB(42) $_DB(43) $_DB(16) $_DB(44) $_DB(8) $_DB(45) $_DB(46) $_DB(9) $_DB(10) $_DB(11) $_DB(47) $_DB(12) $_DB(48) $_DB(49) $_DB(50) $_DB(51) $_DB(52) $_DB(53) $_DB(54) $_DB(55) $_DB(56) $_DB(57) $_DB(58)]
$_TMP(PW_1) do setRenderAttribute FillMode Shaded
$_TMP(PW_1) delete
unset _TMP(PW_1)
pw::Application markUndoLevel {Modify Entity Display}

set _TMP(mode_1) [pw::Application begin SurfaceFit]
  set _TMP(surf_1) [$_TMP(mode_1) createSurfacesFromCurves [list $_DB(7) $_DB(46) $_DB(49) $_DB(50)]]
  $_TMP(mode_1) setBoundaryTolerance [pw::Database getFitTolerance]
  $_TMP(mode_1) setUseBoundaryTangency true
  $_TMP(mode_1) setTangencyEntities [list]
  unset _TMP(surf_1)
$_TMP(mode_1) end
unset _TMP(mode_1)
pw::Application markUndoLevel {Create Patch}

set _TMP(mode_1) [pw::Application begin SurfaceFit]
  set _TMP(surf_1) [$_TMP(mode_1) createSurfacesFromCurves [list $_DB(18) $_DB(5) $_DB(48) $_DB(50)]]
  $_TMP(mode_1) setBoundaryTolerance [pw::Database getFitTolerance]
  $_TMP(mode_1) setUseBoundaryTangency true
  $_TMP(mode_1) setTangencyEntities [list]
  unset _TMP(surf_1)
$_TMP(mode_1) end
unset _TMP(mode_1)
pw::Application markUndoLevel {Create Patch}

set _TMP(mode_1) [pw::Application begin SurfaceFit]
  set _TMP(surf_1) [$_TMP(mode_1) createSurfacesFromCurves [list $_DB(13) $_DB(3) $_DB(43) $_DB(48)]]
  $_TMP(mode_1) setBoundaryTolerance [pw::Database getFitTolerance]
  $_TMP(mode_1) setUseBoundaryTangency true
  $_TMP(mode_1) setTangencyEntities [list]
  unset _TMP(surf_1)
$_TMP(mode_1) end
unset _TMP(mode_1)
pw::Application markUndoLevel {Create Patch}

set _TMP(mode_1) [pw::Application begin SurfaceFit]
  set _TMP(surf_1) [$_TMP(mode_1) createSurfacesFromCurves [list $_DB(2) $_DB(27) $_DB(43) $_DB(49)]]
  $_TMP(mode_1) setBoundaryTolerance [pw::Database getFitTolerance]
  $_TMP(mode_1) setUseBoundaryTangency true
  $_TMP(mode_1) setTangencyEntities [list]
  unset _TMP(surf_1)
$_TMP(mode_1) end
unset _TMP(mode_1)
pw::Application markUndoLevel {Create Patch}

set _DB(59) [pw::DatabaseEntity getByName surface-10]
set _DB(60) [pw::DatabaseEntity getByName surface-11]
set _DB(61) [pw::DatabaseEntity getByName surface-12]
set _DB(62) [pw::DatabaseEntity getByName surface-13]
set _TMP(PW_1) [pw::Collection create]
$_TMP(PW_1) set [list $_DB(1) $_DB(2) $_DB(20) $_DB(21) $_DB(22) $_DB(23) $_DB(13) $_DB(24) $_DB(17) $_DB(25) $_DB(26) $_DB(27) $_DB(3) $_DB(18) $_DB(4) $_DB(28) $_DB(29) $_DB(30) $_DB(14) $_DB(31) $_DB(32) $_DB(33) $_DB(34) $_DB(35) $_DB(19) $_DB(5) $_DB(36) $_DB(37) $_DB(6) $_DB(15) $_DB(7) $_DB(38) $_DB(39) $_DB(40) $_DB(41) $_DB(42) $_DB(43) $_DB(16) $_DB(44) $_DB(8) $_DB(45) $_DB(46) $_DB(9) $_DB(10) $_DB(11) $_DB(47) $_DB(12) $_DB(48) $_DB(49) $_DB(50) $_DB(51) $_DB(52) $_DB(53) $_DB(54) $_DB(55) $_DB(56) $_DB(57) $_DB(58) $_DB(59) $_DB(60) $_DB(61) $_DB(62)]
$_TMP(PW_1) do setRenderAttribute FillMode Shaded
$_TMP(PW_1) delete
unset _TMP(PW_1)
pw::Application markUndoLevel {Modify Entity Display}

set _TMP(mode_1) [pw::Application begin Modify [list $_DB(34) $_DB(35) $_DB(51) $_DB(53) $_DB(54) $_DB(55) $_DB(56) $_DB(57) $_DB(58) $_DB(59) $_DB(60) $_DB(61) $_DB(62)]]
  set _TMP(PW_1) [pw::Model assemble -reject _TMP(rejectEnts) -rejectReason _TMP(rejectReasons) -rejectLocation _TMP(rejectLocations) [list $_DB(34) $_DB(35) $_DB(51) $_DB(53) $_DB(54) $_DB(55) $_DB(56) $_DB(57) $_DB(58) $_DB(59) $_DB(60) $_DB(61) $_DB(62)]]
  unset _TMP(rejectEnts)
  unset _TMP(rejectReasons)
  unset _TMP(rejectLocations)
$_TMP(mode_1) end
unset _TMP(mode_1)
unset _TMP(PW_1)
pw::Application markUndoLevel {Assemble Models}


##################################
## Begin Meshing 
##################################


pw::Connector setDefault Dimension $defaultN
set _DB(1) [pw::DatabaseEntity getByName quilt-3]
set _DB(2) [pw::DatabaseEntity getByName quilt-4]
set _DB(3) [pw::DatabaseEntity getByName quilt-1]
set _DB(4) [pw::DatabaseEntity getByName quilt-2]
set _DB(5) [pw::DatabaseEntity getByName quilt-5]
set _DB(6) [pw::DatabaseEntity getByName model-1]
set _DB(7) [pw::DatabaseEntity getByName surface-6-quilt]
set _DB(8) [pw::DatabaseEntity getByName surface-7-quilt]
set _DB(9) [pw::DatabaseEntity getByName surface-8-quilt]
set _DB(10) [pw::DatabaseEntity getByName surface-9-quilt]
set _DB(11) [pw::DatabaseEntity getByName surface-10-quilt]
set _DB(12) [pw::DatabaseEntity getByName surface-11-quilt]
set _DB(13) [pw::DatabaseEntity getByName surface-12-quilt]
set _DB(14) [pw::DatabaseEntity getByName surface-13-quilt]
set _TMP(PW_1) [pw::DomainStructured createOnDatabase -parametricConnectors Aligned -merge 0 -reject _TMP(unused) [list $_DB(1) $_DB(2) $_DB(3) $_DB(4) $_DB(5) $_DB(6) $_DB(7) $_DB(8) $_DB(9) $_DB(10) $_DB(11) $_DB(12) $_DB(13) $_DB(14)]]
unset _TMP(unused)
unset _TMP(PW_1)
pw::Application markUndoLevel {Domains On DB Entities}




pw::Display setShowDatabase 0
set _CN(1) [pw::GridEntity getByName con-2]
set _CN(2) [pw::GridEntity getByName con-3]
set _CN(3) [pw::GridEntity getByName con-1]
set _CN(4) [pw::GridEntity getByName con-4]
set _CN(5) [pw::GridEntity getByName con-5]
set _CN(6) [pw::GridEntity getByName con-6]
set _CN(7) [pw::GridEntity getByName con-7]
set _CN(8) [pw::GridEntity getByName con-8]
set _CN(9) [pw::GridEntity getByName con-9]
set _CN(10) [pw::GridEntity getByName con-10]
set _CN(11) [pw::GridEntity getByName con-11]
set _CN(12) [pw::GridEntity getByName con-12]
set _CN(13) [pw::GridEntity getByName con-13]
set _CN(14) [pw::GridEntity getByName con-14]
set _CN(15) [pw::GridEntity getByName con-15]
set _CN(16) [pw::GridEntity getByName con-16]
set _CN(17) [pw::GridEntity getByName con-17]
set _CN(18) [pw::GridEntity getByName con-18]
set _CN(19) [pw::GridEntity getByName con-19]
set _CN(20) [pw::GridEntity getByName con-20]
set _CN(21) [pw::GridEntity getByName con-21]
set _CN(22) [pw::GridEntity getByName con-22]
set _CN(23) [pw::GridEntity getByName con-23]
set _CN(24) [pw::GridEntity getByName con-24]
set _CN(25) [pw::GridEntity getByName con-25]
set _CN(26) [pw::GridEntity getByName con-26]
set _CN(27) [pw::GridEntity getByName con-27]
set _CN(28) [pw::GridEntity getByName con-28]
set _DM(1) [pw::GridEntity getByName quilt-1-dom]
set _DM(2) [pw::GridEntity getByName quilt-2-dom]
set _DM(3) [pw::GridEntity getByName quilt-3-dom]
set _DM(4) [pw::GridEntity getByName quilt-4-dom]
set _DM(5) [pw::GridEntity getByName quilt-5-dom]
set _DM(6) [pw::GridEntity getByName surface-6-quilt-dom]
set _DM(7) [pw::GridEntity getByName surface-7-quilt-dom]
set _DM(8) [pw::GridEntity getByName surface-8-quilt-dom]
set _DM(9) [pw::GridEntity getByName surface-9-quilt-dom]
set _DM(10) [pw::GridEntity getByName surface-10-quilt-dom]
set _DM(11) [pw::GridEntity getByName surface-11-quilt-dom]
set _DM(12) [pw::GridEntity getByName surface-12-quilt-dom]
set _DM(13) [pw::GridEntity getByName surface-13-quilt-dom]
set _TMP(PW_1) [pw::Collection create]
$_TMP(PW_1) set [list $_CN(1) $_CN(2) $_CN(3) $_CN(4) $_CN(5) $_CN(6) $_CN(7) $_CN(8) $_CN(9) $_CN(10) $_CN(11) $_CN(12) $_CN(13) $_CN(14) $_CN(15) $_CN(16) $_CN(17) $_CN(18) $_CN(19) $_CN(20) $_CN(21) $_CN(22) $_CN(23) $_CN(24) $_CN(25) $_CN(26) $_CN(27) $_CN(28) $_DM(1) $_DM(2) $_DM(3) $_DM(4) $_DM(5) $_DM(6) $_DM(7) $_DM(8) $_DM(9) $_DM(10) $_DM(11) $_DM(12) $_DM(13)]
$_TMP(PW_1) do setRenderAttribute FillMode HiddenLine
$_TMP(PW_1) delete
unset _TMP(PW_1)
pw::Application markUndoLevel {Modify Entity Display}

# Set tower spanwise N
set _TMP(PW_1) [pw::Collection create]
$_TMP(PW_1) set [list $_CN(13) $_CN(15) $_CN(17) $_CN(21)]
$_TMP(PW_1) do setDimension $towerSpanN
$_TMP(PW_1) delete
unset _TMP(PW_1)
pw::CutPlane refresh
pw::Application markUndoLevel Dimension

set _CN(1) [pw::GridEntity getByName con-26]
set _CN(2) [pw::GridEntity getByName con-27]
set _CN(3) [pw::GridEntity getByName con-25]
set _CN(4) [pw::GridEntity getByName con-28]
set _TMP(PW_1) [pw::Collection create]
$_TMP(PW_1) set [list $_CN(1) $_CN(2) $_CN(3) $_CN(4)]
$_TMP(PW_1) do setDimension $filletN
$_TMP(PW_1) delete
unset _TMP(PW_1)
pw::CutPlane refresh
pw::Application markUndoLevel Dimension

set _CN(5) [pw::GridEntity getByName con-11]
set _CN(6) [pw::GridEntity getByName con-5]
set _CN(7) [pw::GridEntity getByName con-6]
set _CN(8) [pw::GridEntity getByName con-8]
set _TMP(PW_1) [pw::Collection create]
$_TMP(PW_1) set [list $_CN(5) $_CN(6) $_CN(7) $_CN(8)]
$_TMP(PW_1) do setDimension $capN
$_TMP(PW_1) delete
unset _TMP(PW_1)
pw::CutPlane refresh
pw::Application markUndoLevel Dimension

set _TMP(mode_1) [pw::Application begin Modify [list $_CN(13) $_CN(15) $_CN(17) $_CN(21)]]
  pw::Connector swapDistribution MRQS [list [list $_CN(13) 1] [list $_CN(15) 1] [list $_CN(17) 1] [list $_CN(21) 1]]
#  [[$_CN(13) getDistribution 1] getBeginSpacing] setValue 0.1
#  [[$_CN(15) getDistribution 1] getEndSpacing] setValue 0.1
#  [[$_CN(17) getDistribution 1] getBeginSpacing] setValue 0.1
#  [[$_CN(21) getDistribution 1] getEndSpacing] setValue 0.1
#  [[$_CN(13) getDistribution 1] getBeginSpacing] setValue 0.08
#  [[$_CN(15) getDistribution 1] getEndSpacing] setValue 0.08
#  [[$_CN(17) getDistribution 1] getBeginSpacing] setValue 0.08
#  [[$_CN(21) getDistribution 1] getEndSpacing] setValue 0.08
$_TMP(mode_1) end
unset _TMP(mode_1)
pw::Application markUndoLevel Distribute

set _TMP(PW_1) [pw::Collection create]
$_TMP(PW_1) set [list $_CN(5) $_CN(6) $_CN(8) $_CN(11)]
$_TMP(PW_1) do setDimension $capN
$_TMP(PW_1) delete
unset _TMP(PW_1)
pw::CutPlane refresh
pw::Application markUndoLevel Dimension

set _TMP(mode_1) [pw::Application begin SpacingSync]
  set _TMP(PW_1) [pw::Connector synchronizeSpacings -minimum -keepDimensionAndDistribution -growthRate 1.2 -returnDuplicates -undefined _TMP(undefinedDoms) [list $_CN(1) $_CN(2) $_CN(3) $_CN(4) $_CN(5) $_CN(6) $_CN(7) $_CN(8) $_CN(9) $_CN(10) $_CN(11) $_CN(12) $_CN(13) $_CN(15) $_CN(16) $_CN(17) $_CN(19) $_CN(21) $_CN(22) $_CN(24) $_CN(25) $_CN(26) $_CN(27) $_CN(28)]]
  unset _TMP(PW_1)
$_TMP(mode_1) end
unset _TMP(mode_1)
pw::Application markUndoLevel {Sync Spacings}

set ents [list $_DM(1) $_DM(10) $_DM(11) $_DM(12) $_DM(13) $_DM(2) $_DM(3) $_DM(4) $_DM(5) $_DM(6) $_DM(7) $_DM(8) $_DM(9)]
set _TMP(mode_1) [pw::Application begin Modify $ents]
  $_DM(1) setOrientation IMaximum JMinimum
  $_DM(1) setOrientation IMaximum JMinimum
  $_DM(1) setOrientation IMaximum JMinimum
  $_DM(1) alignOrientation [list $_DM(1) $_DM(10) $_DM(11) $_DM(12) $_DM(13) $_DM(2) $_DM(3) $_DM(4) $_DM(5) $_DM(6) $_DM(7) $_DM(8) $_DM(9)]
$_TMP(mode_1) end
unset _TMP(mode_1)
pw::Application markUndoLevel Orient

set _TMP(mode_1) [pw::Application begin Create]
  set _TMP(PW_1) [pw::FaceStructured createFromDomains [list $_DM(1) $_DM(2) $_DM(3) $_DM(4) $_DM(5) $_DM(6) $_DM(7) $_DM(8) $_DM(9) $_DM(10) $_DM(11) $_DM(12) $_DM(13)]]
  set _TMP(face_1) [lindex $_TMP(PW_1) 0]
  set _TMP(face_2) [lindex $_TMP(PW_1) 1]
  set _TMP(face_3) [lindex $_TMP(PW_1) 2]
  unset _TMP(PW_1)
  $_TMP(face_3) delete
  unset _TMP(face_3)
  $_TMP(face_2) delete
  unset _TMP(face_2)
  $_TMP(face_1) delete
  unset _TMP(face_1)
  set _TMP(face_1) [pw::FaceStructured createFromDomains $_DM(1)]
  set _TMP(face_2) [pw::FaceStructured createFromDomains $_DM(2)]
  set _TMP(face_3) [pw::FaceStructured createFromDomains $_DM(3)]
  set _TMP(face_4) [pw::FaceStructured createFromDomains $_DM(4)]
  set _TMP(face_5) [pw::FaceStructured createFromDomains $_DM(5)]
  set _TMP(face_6) [pw::FaceStructured createFromDomains $_DM(6)]
  set _TMP(face_7) [pw::FaceStructured createFromDomains $_DM(7)]
  set _TMP(face_8) [pw::FaceStructured createFromDomains $_DM(8)]
  set _TMP(face_9) [pw::FaceStructured createFromDomains $_DM(9)]
  set _TMP(face_10) [pw::FaceStructured createFromDomains $_DM(10)]
  set _TMP(face_11) [pw::FaceStructured createFromDomains $_DM(11)]
  set _TMP(face_12) [pw::FaceStructured createFromDomains $_DM(12)]
  set _TMP(face_13) [pw::FaceStructured createFromDomains $_DM(13)]
  set _BL(1) [pw::BlockStructured create]
  $_BL(1) addFace $_TMP(face_1)
  set _BL(2) [pw::BlockStructured create]
  $_BL(2) addFace $_TMP(face_2)
  set _BL(3) [pw::BlockStructured create]
  $_BL(3) addFace $_TMP(face_3)
  set _BL(4) [pw::BlockStructured create]
  $_BL(4) addFace $_TMP(face_4)
  set _BL(5) [pw::BlockStructured create]
  $_BL(5) addFace $_TMP(face_5)
  set _BL(6) [pw::BlockStructured create]
  $_BL(6) addFace $_TMP(face_6)
  set _BL(7) [pw::BlockStructured create]
  $_BL(7) addFace $_TMP(face_7)
  set _BL(8) [pw::BlockStructured create]
  $_BL(8) addFace $_TMP(face_8)
  set _BL(9) [pw::BlockStructured create]
  $_BL(9) addFace $_TMP(face_9)
  set _BL(10) [pw::BlockStructured create]
  $_BL(10) addFace $_TMP(face_10)
  set _BL(11) [pw::BlockStructured create]
  $_BL(11) addFace $_TMP(face_11)
  set _BL(12) [pw::BlockStructured create]
  $_BL(12) addFace $_TMP(face_12)
  set _BL(13) [pw::BlockStructured create]
  $_BL(13) addFace $_TMP(face_13)
$_TMP(mode_1) end
unset _TMP(mode_1)
set _TMP(mode_1) [pw::Application begin ExtrusionSolver [list $_BL(1) $_BL(2) $_BL(3) $_BL(4) $_BL(5) $_BL(6) $_BL(7) $_BL(8) $_BL(9) $_BL(10) $_BL(11) $_BL(12) $_BL(13)]]
  $_TMP(mode_1) setKeepFailingStep true
  $_BL(6) setExtrusionBoundaryCondition [list 1 1] ConstantZ
  $_BL(7) setExtrusionBoundaryCondition [list 1 1] ConstantZ
  $_BL(8) setExtrusionBoundaryCondition [list 1 1] ConstantZ
  $_BL(9) setExtrusionBoundaryCondition [list 1 1] ConstantZ
  $_BL(1) setExtrusionSolverAttribute NormalInitialStepSize $initStep
  $_BL(2) setExtrusionSolverAttribute NormalInitialStepSize $initStep
  $_BL(3) setExtrusionSolverAttribute NormalInitialStepSize $initStep
  $_BL(4) setExtrusionSolverAttribute NormalInitialStepSize $initStep
  $_BL(5) setExtrusionSolverAttribute NormalInitialStepSize $initStep
  $_BL(6) setExtrusionSolverAttribute NormalInitialStepSize $initStep
  $_BL(7) setExtrusionSolverAttribute NormalInitialStepSize $initStep
  $_BL(8) setExtrusionSolverAttribute NormalInitialStepSize $initStep
  $_BL(9) setExtrusionSolverAttribute NormalInitialStepSize $initStep
  $_BL(10) setExtrusionSolverAttribute NormalInitialStepSize $initStep
  $_BL(11) setExtrusionSolverAttribute NormalInitialStepSize $initStep
  $_BL(12) setExtrusionSolverAttribute NormalInitialStepSize $initStep
  $_BL(13) setExtrusionSolverAttribute NormalInitialStepSize $initStep
  $_BL(1) setExtrusionSolverAttribute SpacingGrowthFactor $growthFactor
  $_BL(2) setExtrusionSolverAttribute SpacingGrowthFactor $growthFactor
  $_BL(3) setExtrusionSolverAttribute SpacingGrowthFactor $growthFactor
  $_BL(4) setExtrusionSolverAttribute SpacingGrowthFactor $growthFactor
  $_BL(5) setExtrusionSolverAttribute SpacingGrowthFactor $growthFactor
  $_BL(6) setExtrusionSolverAttribute SpacingGrowthFactor $growthFactor
  $_BL(7) setExtrusionSolverAttribute SpacingGrowthFactor $growthFactor
  $_BL(8) setExtrusionSolverAttribute SpacingGrowthFactor $growthFactor
  $_BL(9) setExtrusionSolverAttribute SpacingGrowthFactor $growthFactor
  $_BL(10) setExtrusionSolverAttribute SpacingGrowthFactor $growthFactor
  $_BL(11) setExtrusionSolverAttribute SpacingGrowthFactor $growthFactor
  $_BL(12) setExtrusionSolverAttribute SpacingGrowthFactor $growthFactor
  $_BL(13) setExtrusionSolverAttribute SpacingGrowthFactor $growthFactor
  $_BL(1) setExtrusionSolverAttribute PlaneAngleTolerance 5
  $_BL(2) setExtrusionSolverAttribute PlaneAngleTolerance 5
  $_BL(3) setExtrusionSolverAttribute PlaneAngleTolerance 5
  $_BL(4) setExtrusionSolverAttribute PlaneAngleTolerance 5
  $_BL(5) setExtrusionSolverAttribute PlaneAngleTolerance 5
  $_BL(6) setExtrusionSolverAttribute PlaneAngleTolerance 5
  $_BL(7) setExtrusionSolverAttribute PlaneAngleTolerance 5
  $_BL(8) setExtrusionSolverAttribute PlaneAngleTolerance 5
  $_BL(9) setExtrusionSolverAttribute PlaneAngleTolerance 5
  $_BL(10) setExtrusionSolverAttribute PlaneAngleTolerance 5
  $_BL(11) setExtrusionSolverAttribute PlaneAngleTolerance 5
  $_BL(12) setExtrusionSolverAttribute PlaneAngleTolerance 5
  $_BL(13) setExtrusionSolverAttribute PlaneAngleTolerance 5
  $_BL(1) setExtrusionSolverAttribute NormalExplicitSmoothing [list $expSmooth $expSmooth]
  $_BL(2) setExtrusionSolverAttribute NormalExplicitSmoothing [list $expSmooth $expSmooth]
  $_BL(3) setExtrusionSolverAttribute NormalExplicitSmoothing [list $expSmooth $expSmooth]
  $_BL(4) setExtrusionSolverAttribute NormalExplicitSmoothing [list $expSmooth $expSmooth]
  $_BL(5) setExtrusionSolverAttribute NormalExplicitSmoothing [list $expSmooth $expSmooth]
  $_BL(6) setExtrusionSolverAttribute NormalExplicitSmoothing [list $expSmooth $expSmooth]
  $_BL(7) setExtrusionSolverAttribute NormalExplicitSmoothing [list $expSmooth $expSmooth]
  $_BL(8) setExtrusionSolverAttribute NormalExplicitSmoothing [list $expSmooth $expSmooth]
  $_BL(9) setExtrusionSolverAttribute NormalExplicitSmoothing [list $expSmooth $expSmooth]
  $_BL(10) setExtrusionSolverAttribute NormalExplicitSmoothing [list $expSmooth $expSmooth]
  $_BL(11) setExtrusionSolverAttribute NormalExplicitSmoothing [list $expSmooth $expSmooth]
  $_BL(12) setExtrusionSolverAttribute NormalExplicitSmoothing [list $expSmooth $expSmooth]
  $_BL(13) setExtrusionSolverAttribute NormalExplicitSmoothing [list $expSmooth $expSmooth]
  $_BL(1) setExtrusionSolverAttribute NormalImplicitSmoothing [list $impSmooth $impSmooth]
  $_BL(2) setExtrusionSolverAttribute NormalImplicitSmoothing [list $impSmooth $impSmooth]
  $_BL(3) setExtrusionSolverAttribute NormalImplicitSmoothing  [list $impSmooth $impSmooth]
  $_BL(4) setExtrusionSolverAttribute NormalImplicitSmoothing  [list $impSmooth $impSmooth]
  $_BL(5) setExtrusionSolverAttribute NormalImplicitSmoothing  [list $impSmooth $impSmooth]
  $_BL(6) setExtrusionSolverAttribute NormalImplicitSmoothing  [list $impSmooth $impSmooth]
  $_BL(7) setExtrusionSolverAttribute NormalImplicitSmoothing  [list $impSmooth $impSmooth]
  $_BL(8) setExtrusionSolverAttribute NormalImplicitSmoothing  [list $impSmooth $impSmooth]
  $_BL(9) setExtrusionSolverAttribute NormalImplicitSmoothing  [list $impSmooth $impSmooth]
  $_BL(10) setExtrusionSolverAttribute NormalImplicitSmoothing [list $impSmooth $impSmooth]
  $_BL(11) setExtrusionSolverAttribute NormalImplicitSmoothing [list $impSmooth $impSmooth]
  $_BL(12) setExtrusionSolverAttribute NormalImplicitSmoothing [list $impSmooth $impSmooth]
  $_BL(13) setExtrusionSolverAttribute NormalImplicitSmoothing [list $impSmooth $impSmooth]
  $_BL(1) setExtrusionSolverAttribute NormalKinseyBarthSmoothing  [list $kbSmooth $kbSmooth]
  $_BL(2) setExtrusionSolverAttribute NormalKinseyBarthSmoothing  [list $kbSmooth $kbSmooth]
  $_BL(3) setExtrusionSolverAttribute NormalKinseyBarthSmoothing  [list $kbSmooth $kbSmooth]
  $_BL(4) setExtrusionSolverAttribute NormalKinseyBarthSmoothing  [list $kbSmooth $kbSmooth]
  $_BL(5) setExtrusionSolverAttribute NormalKinseyBarthSmoothing  [list $kbSmooth $kbSmooth]
  $_BL(6) setExtrusionSolverAttribute NormalKinseyBarthSmoothing  [list $kbSmooth $kbSmooth]
  $_BL(7) setExtrusionSolverAttribute NormalKinseyBarthSmoothing  [list $kbSmooth $kbSmooth]
  $_BL(8) setExtrusionSolverAttribute NormalKinseyBarthSmoothing  [list $kbSmooth $kbSmooth]
  $_BL(9) setExtrusionSolverAttribute NormalKinseyBarthSmoothing  [list $kbSmooth $kbSmooth]
  $_BL(10) setExtrusionSolverAttribute NormalKinseyBarthSmoothing [list $kbSmooth $kbSmooth]
  $_BL(11) setExtrusionSolverAttribute NormalKinseyBarthSmoothing [list $kbSmooth $kbSmooth]
  $_BL(12) setExtrusionSolverAttribute NormalKinseyBarthSmoothing [list $kbSmooth $kbSmooth]
  $_BL(13) setExtrusionSolverAttribute NormalKinseyBarthSmoothing [list $kbSmooth $kbSmooth]
  $_BL(1) setExtrusionSolverAttribute NormalVolumeSmoothing  $volCoeff
  $_BL(2) setExtrusionSolverAttribute NormalVolumeSmoothing  $volCoeff
  $_BL(3) setExtrusionSolverAttribute NormalVolumeSmoothing  $volCoeff
  $_BL(4) setExtrusionSolverAttribute NormalVolumeSmoothing  $volCoeff
  $_BL(5) setExtrusionSolverAttribute NormalVolumeSmoothing  $volCoeff
  $_BL(6) setExtrusionSolverAttribute NormalVolumeSmoothing  $volCoeff
  $_BL(7) setExtrusionSolverAttribute NormalVolumeSmoothing  $volCoeff
  $_BL(8) setExtrusionSolverAttribute NormalVolumeSmoothing  $volCoeff
  $_BL(9) setExtrusionSolverAttribute NormalVolumeSmoothing  $volCoeff
  $_BL(10) setExtrusionSolverAttribute NormalVolumeSmoothing $volCoeff
  $_BL(11) setExtrusionSolverAttribute NormalVolumeSmoothing $volCoeff
  $_BL(12) setExtrusionSolverAttribute NormalVolumeSmoothing $volCoeff
  $_BL(13) setExtrusionSolverAttribute NormalVolumeSmoothing $volCoeff
# $_BL(1) setExtrusionSolverAttribute NormalQualitySmoothing true
# $_BL(2) setExtrusionSolverAttribute NormalQualitySmoothing true
# $_BL(3) setExtrusionSolverAttribute NormalQualitySmoothing true
# $_BL(4) setExtrusionSolverAttribute NormalQualitySmoothing true
# $_BL(5) setExtrusionSolverAttribute NormalQualitySmoothing true
# $_BL(6) setExtrusionSolverAttribute NormalQualitySmoothing true
# $_BL(7) setExtrusionSolverAttribute NormalQualitySmoothing true
# $_BL(8) setExtrusionSolverAttribute NormalQualitySmoothing true
# $_BL(9) setExtrusionSolverAttribute NormalQualitySmoothing true
# $_BL(10) setExtrusionSolverAttribute NormalQualitySmoothing true
# $_BL(11) setExtrusionSolverAttribute NormalQualitySmoothing true
# $_BL(12) setExtrusionSolverAttribute NormalQualitySmoothing true
# $_BL(13) setExtrusionSolverAttribute NormalQualitySmoothing true
  $_TMP(mode_1) run $extrusionLevels
  $_TMP(mode_1) run -1
$_TMP(mode_1) end
unset _TMP(mode_1)
pw::Application markUndoLevel {Extrude, Normal}

unset _TMP(face_13)
unset _TMP(face_12)
unset _TMP(face_11)
unset _TMP(face_10)
unset _TMP(face_9)
unset _TMP(face_8)
unset _TMP(face_7)
unset _TMP(face_6)
unset _TMP(face_5)
unset _TMP(face_4)
unset _TMP(face_3)
unset _TMP(face_2)
unset _TMP(face_1)


###################################
# BCs and Export
###################################

pw::Application setCAESolver {EXODUS II} 3
pw::Application markUndoLevel {Select Solver}

set _TMP(PW_1) [pw::BoundaryCondition create]
pw::Application markUndoLevel {Create BC}

unset _TMP(PW_1)
set _TMP(PW_1) [pw::BoundaryCondition getByName bc-2]
$_TMP(PW_1) setName tower-ground
pw::Application markUndoLevel {Name BC}

$_TMP(PW_1) setPhysicalType -usage CAE {Side Set}
pw::Application markUndoLevel {Change BC Type}

set _DM(1) [pw::GridEntity getByName dom-46]
set _BL(1) [pw::GridEntity getByName blk-7]
set _DM(2) [pw::GridEntity getByName dom-51]
set _BL(2) [pw::GridEntity getByName blk-9]
set _DM(3) [pw::GridEntity getByName dom-56]
set _BL(3) [pw::GridEntity getByName blk-8]
set _DM(4) [pw::GridEntity getByName dom-61]
set _BL(4) [pw::GridEntity getByName blk-6]
$_TMP(PW_1) apply [list [list $_BL(1) $_DM(1)] [list $_BL(2) $_DM(2)] [list $_BL(3) $_DM(3)] [list $_BL(4) $_DM(4)]]
pw::Application markUndoLevel {Set BC}

set _DM(5) [pw::GridEntity getByName dom-50]
set _DM(6) [pw::GridEntity getByName dom-30]
set _DM(7) [pw::GridEntity getByName dom-55]
set _DM(8) [pw::GridEntity getByName dom-65]
set _DM(9) [pw::GridEntity getByName dom-60]
set _DM(10) [pw::GridEntity getByName dom-35]
set _DM(11) [pw::GridEntity getByName dom-45]
set _DM(12) [pw::GridEntity getByName dom-10]
set _DM(13) [pw::GridEntity getByName dom-25]
set _DM(14) [pw::GridEntity getByName dom-5]
set _DM(15) [pw::GridEntity getByName dom-40]
set _DM(16) [pw::GridEntity getByName dom-15]
set _DM(17) [pw::GridEntity getByName dom-20]
set _TMP(PW_2) [pw::BoundaryCondition create]
pw::Application markUndoLevel {Create BC}

unset _TMP(PW_2)
set _TMP(PW_2) [pw::BoundaryCondition getByName bc-3]
$_TMP(PW_2) setName tower-overset
pw::Application markUndoLevel {Name BC}

$_TMP(PW_2) setPhysicalType -usage CAE {Side Set}
pw::Application markUndoLevel {Change BC Type}

set _BL(5) [pw::GridEntity getByName blk-13]
set _BL(6) [pw::GridEntity getByName blk-1]
set _BL(7) [pw::GridEntity getByName blk-12]
set _BL(8) [pw::GridEntity getByName blk-2]
set _BL(9) [pw::GridEntity getByName blk-5]
set _BL(10) [pw::GridEntity getByName blk-11]
set _BL(11) [pw::GridEntity getByName blk-10]
set _BL(12) [pw::GridEntity getByName blk-4]
set _BL(13) [pw::GridEntity getByName blk-3]
$_TMP(PW_2) apply [list [list $_BL(5) $_DM(10)] [list $_BL(1) $_DM(5)] [list $_BL(6) $_DM(14)] [list $_BL(7) $_DM(6)] [list $_BL(8) $_DM(12)] [list $_BL(9) $_DM(13)] [list $_BL(10) $_DM(11)] [list $_BL(11) $_DM(15)] [list $_BL(2) $_DM(7)] [list $_BL(12) $_DM(17)] [list $_BL(13) $_DM(16)] [list $_BL(4) $_DM(8)] [list $_BL(3) $_DM(9)]]
pw::Application markUndoLevel {Set BC}

set _DM(18) [pw::GridEntity getByName surface-7-quilt-dom]
set _DM(19) [pw::GridEntity getByName surface-9-quilt-dom]
set _DM(20) [pw::GridEntity getByName surface-6-quilt-dom]
set _DM(21) [pw::GridEntity getByName surface-12-quilt-dom]
set _DM(22) [pw::GridEntity getByName quilt-2-dom]
set _DM(23) [pw::GridEntity getByName surface-8-quilt-dom]
set _DM(24) [pw::GridEntity getByName surface-13-quilt-dom]
set _DM(25) [pw::GridEntity getByName surface-11-quilt-dom]
set _DM(26) [pw::GridEntity getByName quilt-5-dom]
set _DM(27) [pw::GridEntity getByName quilt-3-dom]
set _DM(28) [pw::GridEntity getByName surface-10-quilt-dom]
set _DM(29) [pw::GridEntity getByName quilt-1-dom]
set _DM(30) [pw::GridEntity getByName quilt-4-dom]
set _TMP(PW_3) [pw::BoundaryCondition create]
pw::Application markUndoLevel {Create BC}

unset _TMP(PW_3)
set _TMP(PW_3) [pw::BoundaryCondition getByName bc-4]
$_TMP(PW_3) setName tower-wall
pw::Application markUndoLevel {Name BC}

$_TMP(PW_3) setPhysicalType -usage CAE {Side Set}
pw::Application markUndoLevel {Change BC Type}

$_TMP(PW_3) apply [list [list $_BL(1) $_DM(18)] [list $_BL(7) $_DM(21)] [list $_BL(10) $_DM(25)] [list $_BL(4) $_DM(20)] [list $_BL(11) $_DM(28)] [list $_BL(13) $_DM(27)] [list $_BL(9) $_DM(26)] [list $_BL(6) $_DM(29)] [list $_BL(2) $_DM(19)] [list $_BL(8) $_DM(22)] [list $_BL(5) $_DM(24)] [list $_BL(3) $_DM(23)] [list $_BL(12) $_DM(30)]]
pw::Application markUndoLevel {Set BC}

unset _TMP(PW_1)
unset _TMP(PW_2)
unset _TMP(PW_3)
set _TMP(PW_1) [pw::VolumeCondition create]
pw::Application markUndoLevel {Create VC}

$_TMP(PW_1) setName tower-fluid
pw::Application markUndoLevel {Name VC}

$_TMP(PW_1) apply [list $_BL(6) $_BL(8) $_BL(13) $_BL(12) $_BL(9) $_BL(4) $_BL(1) $_BL(3) $_BL(2) $_BL(11) $_BL(10) $_BL(7) $_BL(5)]
pw::Application markUndoLevel {Set VC}

set _DM(31) [pw::GridEntity getByName dom-4]
set _DM(32) [pw::GridEntity getByName dom-1]
set _DM(33) [pw::GridEntity getByName dom-2]
set _DM(34) [pw::GridEntity getByName dom-3]
set _DM(35) [pw::GridEntity getByName dom-34]
set _DM(36) [pw::GridEntity getByName dom-31]
set _DM(37) [pw::GridEntity getByName dom-14]
set _DM(38) [pw::GridEntity getByName dom-29]
set _DM(39) [pw::GridEntity getByName dom-47]
set _DM(40) [pw::GridEntity getByName dom-52]
set _DM(41) [pw::GridEntity getByName dom-11]
set _DM(42) [pw::GridEntity getByName dom-9]
set _DM(43) [pw::GridEntity getByName dom-16]
set _DM(44) [pw::GridEntity getByName dom-17]
set _DM(45) [pw::GridEntity getByName dom-22]
set _DM(46) [pw::GridEntity getByName dom-37]
set _DM(47) [pw::GridEntity getByName dom-42]
set _DM(48) [pw::GridEntity getByName dom-27]
set _DM(49) [pw::GridEntity getByName dom-7]
set _DM(50) [pw::GridEntity getByName dom-57]
set _DM(51) [pw::GridEntity getByName dom-49]
set _DM(52) [pw::GridEntity getByName dom-36]
set _DM(53) [pw::GridEntity getByName dom-28]
set _DM(54) [pw::GridEntity getByName dom-8]
unset _TMP(PW_1)
set _TMP(mode_1) [pw::Application begin CaeExport]
  $_TMP(mode_1) addAllEntities
  $_TMP(mode_1) initialize -strict -type CAE $fileExportLoc
  $_TMP(mode_1) verify
  $_TMP(mode_1) write
$_TMP(mode_1) end
unset _TMP(mode_1)
