#!/usr/bin/bash
export XEE_PATH=`dirname "$(realpath $0)"`
export XEE_EXTERNALS=$XEE_PATH/externals
export XEE_RELEASE="CMSSW_15_0_13";

#cmsrel
scramv1 project $XEE_RELEASE
export CMSSW_SRC=$XEE_PATH/$XEE_RELEASE/src

pushd $CMSSW_SRC
eval `scramv1 runtime -sh` #cmsenv
git cms-init

git cms-addpkg PhysicsTools/PatAlgos
git cms-addpkg TrackingTools/TransientTrack
git cms-addpkg RecoVertex/KinematicFit
git cms-addpkg RecoVertex/VertexTools

git clone git@github.com:pviscone/DoubleElectronNANO.git
git clone -b dpee git@github.com:pviscone/EgammaPostRecoTools.git EgammaUser/EgammaPostRecoTools

cp -rf $XEE_EXTERNALS/* $CMSSW_SRC/

read -p "Do you want to scram now? (y/n)" -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    scram b -j 8
fi
