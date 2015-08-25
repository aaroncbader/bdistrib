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
    0.80748806762884, 0.75673553269543, 0.685698469409079, 0.675471456480586, \
    0.592253825762204, 0.553337967744933, 0.536880519946412,                \
    0.530404373519825, 0.511004844261854, 0.474331160314634,                \
    0.462109427019161, 0.451154522463278, 0.433457638690821,                \
    0.419529556430324, 0.411172548900823, 0.405063731354894,                \
    0.397819745021475, 0.39505583606001, 0.390291769936236, 0.37803431700099,\
    0.369660952208178, 0.360677811057289, 0.34770662447509,                   \
    0.342189411106046, 0.339401099720747, 0.334694486558596,                  \
    0.326766867222216, 0.325706571262854, 0.31245777147489,                   \
    0.312247531506089, 0.305642842072085, 0.305611651518624,                  \
    0.303893047034855, 0.303273809556515, 0.301142853952533,                  \
    0.290679578922983, 0.288073702846488, 0.280291840109593,                  \
    0.279965952730086, 0.272084567461132, 0.271562517627292,                  \
    0.267848206023521, 0.260179248206608, 0.256728536126209,                  \
    0.255650282355266, 0.252965505864391, 0.249931715984706,                  \
    0.242995382740275, 0.238265691962011, 0.237835627119567,                  \
    0.236594342074211, 0.236356177054455, 0.232486092663826,                  \
    0.229416240114077, 0.227048485752016, 0.226322314427967,                  \
    0.223491993206945, 0.223438104495745, 0.220591937040743,                  \
    0.21439224647662, 0.213427801179016, 0.207455646702576,                   \
    0.205960519129138, 0.204607007663195, 0.20285319126846, 0.20198757391766, \
    0.193908059875998, 0.191919618856505, 0.191180180099156,                  \
    0.191152168374675, 0.190786646557076, 0.188527491941821,                  \
    0.18527572678358, 0.185150569579996, 0.183436951664931,                   \
    0.183047578451705, 0.181646383611676, 0.180556776159413,                  \
    0.176637590793367, 0.176457838524904, 0.174280012505383,                  \
    0.174071979993644, 0.171513990198353, 0.167884343218783,                  \
    0.166644521889372, 0.164169021924106, 0.162875480369706,                  \
    0.162234470357403, 0.158271202387223, 0.15607742817747,                   \
    0.155820142145274, 0.153844562416977, 0.153136935245535,                  \
    0.152976758660571, 0.152786799135431, 0.148161125260797,                  \
    0.145625169241385, 0.145083291526552, 0.144109012405632,                  \
    0.143382976757194, 0.141864250094863, 0.141826558747472,                  \
    0.140728544295708, 0.139981860259017, 0.137448185663651,                  \
    0.135420207383498, 0.134065115939962, 0.13403404101008,                   \
    0.129834844891711, 0.129652052278666, 0.129150312611766,                  \
    0.129029424014838, 0.128259192555626, 0.128157790515817,                  \
    0.125100501076374, 0.124696951386487, 0.124502432074929,                  \
    0.123747528973908, 0.12319972210259, 0.122689645748725,                   \
    0.120935073180147, 0.120086317466286, 0.117391577842211,                  \
    0.116778897192163, 0.115250393919338, 0.115237426253966,                  \
    0.111716712748023, 0.111632887621463, 0.111133418638585,                  \
    0.110892805981045, 0.110246430212111, 0.11019267192278,                   \
    0.106861787392204, 0.106839148036375, 0.105962936795265,                  \
    0.105540303485899, 0.103853245868425, 0.103733272555123,                  \
    0.100417112519796, 0.100375138013506, 0.100122349771868,                  \
    0.099872056244205, 0.0987321341815237, 0.0982517451019726,                \
    0.0972751225820664, 0.0972671117470949, 0.0946436193626951,               \
    0.0945530560500737, 0.0929398818781186, 0.0927260499727836,               \
    0.0914274366276194, 0.0912864799721025, 0.0900092776795218,               \
    0.0893653169706842, 0.0887403331244918, 0.0886648604099625,               \
    0.0855588203128888, 0.0854322856661178, 0.0852402137355555,               \
    0.0850642383883472, 0.0840910175560622, 0.0840784398048277,               \
    0.0831437874749994, 0.0829763515360476, 0.081361778376605,                \
    0.0813294623185631, 0.080973445841746, 0.0809582665371887,\
    0.0786559708898749, 0.0786160635290326, 0.0776608409694794,\
    0.0775386609815333, 0.0761209069123619, 0.0759116786151375,\
    0.0749231820974548, 0.0748631368919825, 0.0737048167464603,\
    0.07365955028792, 0.0723011528812707, 0.07226401890076,\
    0.0709080988651448, 0.0708325918894387, 0.0689636244309618,\
    0.0689522730159879, 0.0670616265160607, 0.0670466102773518,\
    0.0667992869428102, 0.0663155205755037, 0.0651712804940814,\
    0.065112056300563, 0.0640696378969124, 0.0637989707319399,\
    0.0617199688641223, 0.0617195043446249, 0.0603430185464408,\
    0.0602382688416292, 0.058977969240951, 0.0589186213594279,\
    0.0579577118014999, 0.0576679032253301, 0.0564220172356355,\
    0.0563820256574022, 0.0561065392001764, 0.0560888686945462,\
    0.0550517495795607, 0.0548580734986213, 0.0545603250219687,\
    0.0545174844090287, 0.0531577187833509, 0.0530750406508522,\
    0.0527611666616702, 0.0526582113966669, 0.0519423933586362,\
    0.0519353012910902, 0.0505608843028748, 0.0505548686346945,\
    0.0498957926617524, 0.0498774284504606, 0.0493285031843179,\
    0.0489630116670319, 0.0485923267369846, 0.0482614222186315,\
    0.0482600988624821, 0.0481648317165402, 0.0458851796770642,\
    0.0458705767691166, 0.0453204211373908, 0.0453100658077973,\
    0.0438967163078364, 0.0437315930233669, 0.043430544801756,\
    0.0431302647753646, 0.043030934814059, 0.0429664117966642,\
    0.0415261465965812, 0.041522089232258, 0.0408559626833285,\
    0.04082779908421, 0.0397487231943223, 0.0395485244625595,\
    0.0393140429743186, 0.039312130280165, 0.0379965547607649,\
    0.0377456638147431, 0.0370601009960838, 0.0370579702672244,\
    0.0368270948421711, 0.0368100381979087, 0.0350877104348513,\
    0.0350857985943965, 0.0348330554913165, 0.0347606263702574,\
    0.0327785876053597, 0.0327312608964106, 0.032522307605403,\
    0.0325208229600923, 0.0323076461344993, 0.0322586575421682,\
    0.0321349520636907, 0.031965483913727, 0.0312702879370531,\
    0.0312493500799578, 0.0293063479548325, 0.0293002851312817,\
    0.0288507844000401, 0.0288498703318876, 0.0284445350850094,\
    0.0283755243631722, 0.0274933456428412, 0.02749323053575,\
    0.0253418152891334, 0.0253403453561967, 0.0245452557028603,\
    0.0245040589629384, 0.0236017497265509, 0.0235848936237654,\
    0.0206456673535241, 0.0206448396950423, 0.0200421049230431,\
    0.0200277194427277, 0.0164860601337803, 0.016486057967995,\
    0.0159614980835693, 0.0159605227677014, 0.0139344297367144,\
    0.0139342789280393, 0.01016095022491, 0.0101606375524978 ], desiredTolerance)


#numFailures += shouldBe(data[0,0], 0.500, desiredTolerance)
#numFailures += arrayShouldBe(data[0,0], 0.500, desiredTolerance)
#numFailures += arrayShouldBe(data[0,:], 0.500, desiredTolerance, requireSameLength=False)

f.close()

print "Number of failures:",numFailures
exit(numFailures > 0)
