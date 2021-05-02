#!/bin/bash
export CLION_HALLDRECON=$1
cat > clion_gluex_version.xml <<- EOF

	<?xml version="1.0" encoding="UTF-8"?>
	<?xml-stylesheet type="text/xsl" href="https://halldweb.jlab.org/dist/version4.xsl"?>
	<gversions file="version_4.37.2.xml" date="2021-04-15">
	<description>Use backward-compatible REST specification.</description>
	<package name="amptools" version="0.11.0"/>
	<package name="ccdb" version="1.06.07"/>
	<package name="cernlib" version="2005" word_length="64-bit"/>
	<package name="diracxx" version="1.0.0"/>
	<package name="evio" version="4.4.6"/>
	<package name="evtgen" version="01.07.00"/>
	<package name="geant4" version="10.02.p02"/>
	<package name="gluex_MCwrapper" version="v2.5.2"/>
	<package name="gluex_root_analysis" version="1.17.0" dirtag="hdr4251"/>
	<package name="halld_recon" home="${CLION_HALLDRECON}"/>
	<package name="halld_sim" version="4.29.0" dirtag="hdr4251"/>
	<package name="hdds" version="4.12.0"/>
	<package name="hdgeant4" version="2.21.0" dirtag="hdr4251"/>
	<package name="hd_utilities" version="1.30"/>
	<package name="hepmc" version="2.06.10"/>
	<package name="jana" version="2.0.4" url="http://github.com/JeffersonLab/JANA2" home="/app/jana2/install"/>
	<package name="lapack" version="3.6.0"/>
	<package name="photos" version="3.61"/>
	<package name="rcdb" version="0.06.00"/>
	<package name="root" home="/app/root"/>
	<package name="sqlitecpp" version="2.2.0" dirtag="bs130"/>
	<package name="sqlite" version="3.13.0" year="2016" dirtag="bs130"/>
	<package name="xerces-c" version="3.1.4"/>
	</gversions>
	EOF

export BUILD_SCRIPTS=/group/halld/Software/build_scripts
export GLUEX_TOP=/group/halld/Software/builds/Linux_CentOS7-x86_64-gcc4.8.5-cntr

source $BUILD_SCRIPTS/gluex_env_boot_jlab.sh > /dev/null 2> /dev/null
gxenv clion_gluex_version.xml #> /dev/null 2> /dev/null
echo "ROOTSYS=$ROOTSYS;JANA_HOME=$JANA_HOME;SIM_RECON_HOME=$SIM_RECON_HOME;HDDS_HOME=$HDDS_HOME;CERN_ROOT=$CERN_ROOT;XERCESCROOT=$XERCESCROOT;CCDB_HOME=$CCDB_HOME;G4ROOT=$G4ROOT;EVIOROOT=$EVIOROOT;RCDB_HOME=$RCDB_HOME;HDGEANT4_HOME=$HDGEANT4_HOME;HD_UTILITIES_HOME=$HD_UTILITIES_HOME;ROOT_ANALYSIS_HOME=$ROOT_ANALYSIS_HOME;AMPTOOLS_HOME=$AMPTOOLS_HOME;SQLITECPP_HOME=$SQLITECPP_HOME;SQLITE_HOME=$SQLITE_HOME;MCWRAPPER_CENTRAL=$MCWRAPPER_CENTRAL;HALLD_SIM_HOME=$HALLD_SIM_HOME;HALLD_RECON_HOME=$HALLD_RECON_HOME;HEPMCDIR=$HEPMCDIR;PHOTOSDIR=$PHOTOSDIR;EVTGENDIR=$EVTGENDIR"

