#!/usr/bin/env python

# This python script checks the output file for an example to 
# see if the results are close to expected values.  This script may be
# run directly, and it is also called when "make test" is run from the
# main BDISTRIB directory.

execfile('../testsCommon.py')

desiredTolerance = 0.001

numFailures = 0

f = readOutputFile()

variableName = 'svd_s_transferMatrix'
data = f.variables[variableName][()]

numFailures += arrayShouldBe(data[0,:], [ \
    0.756733254860545, 0.675471379935325, 0.592208082776024, 0.536884314491204, \
    0.474304119351931, 0.462098639867155, 0.433482824297775,                  \
    0.40504994884439, 0.395088147190296, 0.378002092760559,                   \
    0.369656715956196, 0.342207626946678, 0.334627287931473,                  \
    0.326824776683514, 0.312355089619126, 0.305712027752294,                  \
    0.303350926663656, 0.301176678648187, 0.288128914891327,                  \
    0.280034577096307, 0.271637554610589, 0.260085538016223,                  \
    0.255616286279376, 0.249876146892238, 0.238192304700215,                  \
    0.236560321655081, 0.232465413279583, 0.22713070948282,\
    0.223403714113285, 0.214384017945438, 0.207502997168413,\
    0.204558209532573, 0.202011396131647, 0.191883508432243,\
    0.191195437311696, 0.188523581665167, 0.185294690111036,\
    0.183021274151814, 0.181595026252907, 0.176489218870481,\
    0.174245957077496, 0.17147739256897, 0.166679705693966,\
    0.162844306749977, 0.158286618934456, 0.156019804359829,\
    0.15321023536068, 0.152966798942799, 0.145579688757855,\
    0.144129681784407, 0.141802200925138, 0.140749074973194,\
    0.137454619505406, 0.134086229167065, 0.129633691351194,\
    0.129045270546725, 0.128149070920244, 0.124699505325093,\
    0.123753641386098, 0.1232247541237, 0.120074130931104, 0.117355152256945,\
    0.115289984755215, 0.111710173770693, 0.110884580440802,\
    0.110212806192446, 0.106835826730751, 0.105513704177791,\
    0.103898090212931, 0.100353060501615, 0.100072826078872,\
    0.0982677288706806, 0.0972698589158926, 0.0945747032391133,\
    0.0929268392536622, 0.0913662172162728, 0.0900071127718847,\
    0.0887574228776865, 0.085599196725491, 0.0852461926201933,\
    0.084097083662554, 0.0831740683726667, 0.0813099469428992,\
    0.0809564210197215, 0.0786395793267298, 0.0775260568268283,\
    0.0759165587811006, 0.0749048769083686, 0.0736942554462586,\
    0.0722914708757922, 0.070821402570254, 0.0689209556602549,\
    0.0670578475670874, 0.0668023814959159, 0.0651685088355864,\
    0.0637886767621236, 0.0617339395999649, 0.0602112292729757,\
    0.0589364701458009, 0.0576696290918603, 0.0564426862030125,\
    0.0560965722009176, 0.0548770538166975, 0.0545270522730736,\
    0.0531816138054799, 0.0526697060958566, 0.0519342210325388,\
    0.0505516029199884, 0.0498558126100326, 0.0493499522070477,\
    0.0485763983582292, 0.0482019965953246, 0.0458804642286697,\
    0.0453160913727936, 0.0438351036377598, 0.0434391845491291,\
    0.0430021901080636, 0.0415298325263476, 0.0408199506357601,\
    0.0397396726921648, 0.039325643593938, 0.0379815727825406,\
    0.0370070889282363, 0.0368385851296482, 0.0350713953182917,\
    0.0348342273725422, 0.0327694894997771, 0.0325247368119948,\
    0.0322338320427033, 0.0319503976714992, 0.0312666793080788,\
    0.0292863009933832, 0.028848506684405, 0.0284326064100996,\
    0.0274957338482722, 0.0253290621521502, 0.0245406623214722,\
    0.0236000802279727, 0.0206317716284037, 0.0200424561279252,\
    0.0164764489021121, 0.0159607439014504, 0.0139349008402099,\
    0.0101631867561 ], desiredTolerance)


#numFailures += shouldBe(data[0,0], 0.500, desiredTolerance)
#numFailures += arrayShouldBe(data[0,0], 0.500, desiredTolerance)
#numFailures += arrayShouldBe(data[0,:], 0.500, desiredTolerance, requireSameLength=False)

f.close()
exit(numFailures > 0)
