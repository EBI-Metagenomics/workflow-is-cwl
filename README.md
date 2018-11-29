[![Build Status](https://travis-ci.org/mscheremetjew/workflow-is-cwl.svg?branch=master)](https://travis-ci.org/mscheremetjew/workflow-is-cwl)

# ELIXIR Workflow Implementation Study - CWL descriptions
This repository contains CWL descriptions of the various tools (TransDecoder, Diamond, InterProScan and PHMMER), which will allow you to build workflows for the annotation of transcriptomes.

## CWLEXEC support branch
This branch is suppose to support the workflow execution framework [CWLEXEC](https://github.com/IBMSpectrumComputing/cwlexec).

CWLEXEC currently implements CWL draft-3 and v1.0 with a few exceptions (SoftwareRequirement, include directive, remote location in File/Directory specification).
This branch has been created to work around those exceptions.