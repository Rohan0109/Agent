import 'package:Mugavan/models/chart_model.dart';
import 'package:Mugavan/models/type_data.dart';
import 'package:Mugavan/service/remote_service.dart';
import 'package:Mugavan/utils/constant.dart';
import 'package:breadcrumbs/breadcrumbs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../models/assembly.dart';
import '../models/booth.dart';
import '../models/district.dart';
import '../models/localbody.dart';
import '../models/parliament.dart';
import '../models/party.dart';
import '../models/taluk.dart';
import '../models/voter.dart';
import '../models/ward.dart';

class VoterChart extends StatefulWidget {
  const VoterChart({Key? key}) : super(key: key);

  @override
  State<VoterChart> createState() => _VoterChartState();
}

class _VoterChartState extends State<VoterChart>
    with AutomaticKeepAliveClientMixin {
  final RemoteService _remoteService = RemoteService();

  bool _isLoading = true;
  bool _isTalukLoading = false;
  bool _isParliamentLoading = false;
  bool _isAssemblyLoading = false;
  bool _isLocalbodyLoading = false;
  bool _isWardLoading = false;
  bool _isBoothLoading = false;

  List<District> _districts = [Constant.district];

  List<Taluk> _taluks = [Constant.taluk];

  List<Parliament> _parliaments = [Constant.parliament];

  List<Assembly> _assemblies = [Constant.assembly];

  List<Localbody> _localbodies = [Constant.localbody];

  List<Ward> _wards = [Constant.ward];

  List<Booth> _booths = [Constant.booth];

  District? _district;
  Taluk? _taluk;
  Parliament? _parliament;
  Assembly? _assembly;
  Localbody? _localbody;
  Ward? _ward;
  Booth? _booth;
  Voter? _voter;

  List<Party> _parties = [];
  List<ChartModel> _charts = [];
  int _count = 0;
  int _totalVoters = 0;
  int _ntk = 0;

  List<_PieData> _pipDataSource = [];

  bool _isVoterGeoLocationExpansion = false;

  @override
  void initState() {
    getDistricts();
    _taluk = _taluks[0];
    _parliament = _parliaments[0];
    _assembly = _assemblies[0];
    _localbody = _localbodies[0];
    _ward = _wards[0];
    _booth = _booths[0];
    getParties();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constant.primeColor,
        title: Text('பகுப்பாய்வு'),
      ),
      body: RefreshIndicator(
          onRefresh: _refresh,
          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Visibility(
                          visible: false,
                          child: ExpansionTile(
                            maintainState: true,
                            initiallyExpanded: _isVoterGeoLocationExpansion,
                            title: Breadcrumbs(
                              crumbs: [
                                TextSpan(text: 'தமிழ்நாடு'),
                                TextSpan(
                                    text:
                                        '${_districts[0]?.district.ta.toString()}'),
                                TextSpan(text: 'காஞ்சிபுரம்'),
                                TextSpan(text: 'காஞ்சிபுரம்'),
                                TextSpan(text: 'காஞ்சிபுரம்'),
                                TextSpan(text: 'காஞ்சிபுரம் மாநகராட்சி'),
                                TextSpan(text: 'வார்டு 21'),
                              ],
                              separator: ' > ',
                              style: TextStyle(color: Colors.black),
                            ),
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: DropdownButtonFormField(
                                  validator: (District? value) {
                                    if (value == null || value.id == 0) {
                                      return '* மாவட்டம் தேவை';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      enabled: true,
                                      labelText: 'மாவட்டம்',
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8))),
                                  items: _districts
                                      .map((e) => DropdownMenuItem(
                                            value: e,
                                            child:
                                                Text(e.district.ta.toString()),
                                          ))
                                      .toList(),
                                  value: _district,
                                  isDense: true,
                                  isExpanded: true,
                                  hint: Text(
                                    'உங்கள் மாவட்டத்தைத் தேர்ந்தெடுக்கவும்',
                                  ),
                                  onChanged: (District? value) {
                                    if (value?.id != 0) {
                                      getTaluks(value?.id);
                                      getParliaments(value?.id);
                                      getAssemblies(value?.id);
                                      getLocalbodies(value?.id);
                                    }
                                  },
                                ),
                              ),
                              SizedBox(height: 14),
                              Container(
                                  child: _isTalukLoading
                                      ? Center(
                                          child: CircularProgressIndicator())
                                      : DropdownButtonFormField(
                                          validator: (Taluk? value) {
                                            if (value == null ||
                                                value.id == 0) {
                                              return '* தாலுகா தேவை';
                                            }
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                              enabled: true,
                                              labelText: 'தாலுகா',
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8))),
                                          items: _taluks
                                              ?.map((e) => DropdownMenuItem(
                                                    enabled: true,
                                                    value: e,
                                                    child: Text(
                                                        e.taluk.ta.toString()),
                                                  ))
                                              .toList(),
                                          value: _taluk,
                                          isDense: true,
                                          isExpanded: true,
                                          hint: Text(
                                            'உங்கள் தாலுகாவைத் தேர்ந்தெடுக்கவும்',
                                          ),
                                          onChanged: (Object? value) {},
                                        )),
                              SizedBox(height: 14),
                              Container(
                                  child: _isParliamentLoading
                                      ? Center(
                                          child: CircularProgressIndicator())
                                      : DropdownButtonFormField(
                                          validator: (Parliament? value) {
                                            if (value == null ||
                                                value.id == 0) {
                                              return '* பாராளுமன்றம் தேவை';
                                            }
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                              enabled: true,
                                              labelText: 'பாராளுமன்றம்',
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8))),
                                          items: _parliaments
                                              ?.map((e) => DropdownMenuItem(
                                                    enabled: true,
                                                    value: e,
                                                    child: Text(e
                                                        .parliamentName.ta
                                                        .toString()),
                                                  ))
                                              .toList(),
                                          value: _parliament,
                                          isDense: true,
                                          isExpanded: true,
                                          hint: Text(
                                            'உங்கள் பாராளுமன்றத்தை தேர்ந்தெடுங்கள்',
                                          ),
                                          onChanged: (Object? value) {},
                                        )),
                              SizedBox(
                                height: 14,
                              ),
                              Container(
                                  child: _isAssemblyLoading
                                      ? Center(
                                          child: CircularProgressIndicator())
                                      : DropdownButtonFormField(
                                          validator: (Assembly? value) {
                                            if (value == null ||
                                                value.id == 0) {
                                              return '* சட்டசபை தேவை';
                                            }
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                              enabled: true,
                                              labelText: 'சட்டசபை',
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8))),
                                          items: _assemblies
                                              ?.map((e) => DropdownMenuItem(
                                                    enabled: true,
                                                    value: e,
                                                    child: Text(e.assembly.ta
                                                        .toString()),
                                                  ))
                                              .toList(),
                                          value: _assembly,
                                          isDense: true,
                                          isExpanded: true,
                                          hint: Text(
                                            'உங்கள் சட்டசபையைத் தேர்ந்தெடுக்கவும்',
                                          ),
                                          onChanged: (Object? value) {},
                                        )),
                              SizedBox(
                                height: 14,
                              ),
                              Container(
                                  child: _isLocalbodyLoading
                                      ? Center(
                                          child: CircularProgressIndicator())
                                      : DropdownButtonFormField(
                                          validator: (Localbody? value) {
                                            if (value == null ||
                                                value.id == 0) {
                                              return '* உள்ளாட்சி தேவை';
                                            }
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                              enabled: true,
                                              labelText: 'உள்ளாட்சி',
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8))),
                                          items: _localbodies
                                              ?.map((e) => DropdownMenuItem(
                                                    enabled: true,
                                                    value: e,
                                                    child: Text(e.localbody.ta
                                                        .toString()),
                                                  ))
                                              .toList(),
                                          value: _localbody,
                                          isDense: true,
                                          isExpanded: true,
                                          hint: Text(
                                            'உங்கள் உள்ளாட்சியைத் தேர்ந்தெடுக்கவும்',
                                          ),
                                          onChanged: (Localbody? value) {
                                            if (value?.id != 0) {
                                              getWards(value?.id ?? 0);
                                            }
                                          },
                                        )),
                              SizedBox(
                                height: 14,
                              ),
                              Container(
                                  child: _isWardLoading
                                      ? Center(
                                          child: CircularProgressIndicator())
                                      : DropdownButtonFormField(
                                          validator: (Ward? value) {
                                            if (value == null ||
                                                value.id == 0) {
                                              return '* வார்டு தேவை';
                                            }
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                              enabled: true,
                                              labelText: 'வார்டு',
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8))),
                                          items: _wards
                                              ?.map((e) => DropdownMenuItem(
                                                    enabled: true,
                                                    value: e,
                                                    child: Text(
                                                        e.ward.ta.toString()),
                                                  ))
                                              .toList(),
                                          value: _ward,
                                          isDense: true,
                                          isExpanded: true,
                                          hint: Text(
                                            'உங்கள் வார்டைத் தேர்ந்தெடுக்கவும்',
                                          ),
                                          onChanged: (Ward? value) {
                                            _ward = value!;
                                            if (value?.id != 0) {
                                              // getBooths(value!);
                                            }
                                          },
                                        )),
                              SizedBox(
                                height: 14,
                              ),
                              Visibility(
                                visible: false,
                                child: Container(
                                    child: _isBoothLoading
                                        ? Center(
                                            child: CircularProgressIndicator())
                                        : DropdownButtonFormField(
                                            // validator: (Booth? value) {
                                            //   if (value == null || value.id == 0) {
                                            //     return '* வாக்கு சாவடி தேவை';
                                            //   }
                                            //   return null;
                                            // },
                                            decoration: InputDecoration(
                                                enabled: true,
                                                labelText: 'வாக்கு சாவடி',
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8))),
                                            items: _booths
                                                ?.map((e) => DropdownMenuItem(
                                                      enabled: true,
                                                      value: e,
                                                      child: Text(
                                                          e.name.ta.toString()),
                                                    ))
                                                .toList(),
                                            value: _booth,
                                            isDense: true,
                                            isExpanded: true,
                                            hint: Text(
                                              'உங்கள் வாக்கு சாவடியைத் தேர்ந்தெடுக்கவும்',
                                            ),
                                            onChanged: (Booth? value) {
                                              setState(() {
                                                _booth = value;
                                              });
                                            },
                                          )),
                              ),
                              SizedBox(
                                height: 14,
                              ),
                              MaterialButton(
                                padding: EdgeInsets.all(16.0),
                                minWidth: double.infinity,
                                height: 46,
                                color: Constant.primeColor,
                                textColor: Colors.white,
                                onPressed: () async {
                                  setState(() {
                                    _isVoterGeoLocationExpansion = true;
                                  });
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Text(
                                      'சமர்ப்பி',
                                      style: TextStyle(fontSize: 18.0),
                                    ),
                                    Icon(Icons.arrow_forward)
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'மொத்த வாக்காளரின் எண்ணிக்கை : $_totalVoters',
                          style: TextStyle(fontSize: 16),
                        ),
                        SfCircularChart(
                            title: ChartTitle(
                                text:
                                    'நாம் தமிழர் கட்சிக்கு வாக்களிக்க வாய்ப்புள்ள வாக்காளர்கள்'),
                            legend: Legend(isVisible: true),
                            series: <PieSeries<_PieData, String>>[
                              PieSeries<_PieData, String>(
                                  explode: true,
                                  explodeIndex: 0,
                                  dataSource: _pipDataSource,
                                  xValueMapper: (_PieData data, _) =>
                                      data.xData,
                                  yValueMapper: (_PieData data, _) =>
                                      data.yData,
                                  dataLabelMapper: (_PieData data, _) =>
                                      data.text,
                                  dataLabelSettings:
                                      DataLabelSettings(isVisible: true)),
                            ]),
                      ],
                    ),
                  ),
                )),
    );
  }

  void getDistricts() async {
    try {
      List<District> districts = await _remoteService.getDistricts();
      setState(() {
        _districts = List.of(_districts)..addAll(districts);
      });
      // getAgent();
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      _updateSuccessMessage(e);
    }
  }

  void getTaluks(districtId) async {
    setState(() {
      _isTalukLoading = true;
      _taluks.clear();
      _taluks.add(Constant.taluk);
      _taluk = _taluks[0];
    });
    try {
      List<Taluk> taluks = await _remoteService.getTaluks(districtId);
      setState(() {
        _taluks = List.of(_taluks)..addAll(taluks);
        _isTalukLoading = false;
        for (var i = 0; i < _taluks.length; i++) {
          if (_voter?.talukId == _taluks[i].id) {
            _taluk = _taluks[i];
            break;
          }
        }
      });
    } catch (e) {
      setState(() {
        _isTalukLoading = false;
      });
      _updateSuccessMessage(e);
    }
  }

  void getParliaments(districtId) async {
    setState(() {
      _isParliamentLoading = true;
      _parliaments.clear();
      _parliaments.add(Constant.parliament);
      _parliament = _parliaments[0];
    });
    try {
      List<Parliament> parliaments =
          await _remoteService.getParliaments(districtId);
      setState(() {
        _parliaments = List.of(_parliaments)..addAll(parliaments);
        _isParliamentLoading = false;
        for (var i = 0; i < _parliaments.length; i++) {
          if (_voter?.parliamentId == _parliaments[i].id) {
            _parliament = _parliaments[i];
            break;
          }
        }
      });
    } catch (e) {
      setState(() {
        _isParliamentLoading = false;
      });
      _updateSuccessMessage(e);
    }
  }

  void getAssemblies(districtId) async {
    setState(() {
      _isAssemblyLoading = true;
      _assemblies.clear();
      _assemblies.add(Constant.assembly);
      _assembly = _assemblies[0];
    });
    try {
      List<Assembly> assemblies =
          await _remoteService.getAssemblies(districtId);
      setState(() {
        _assemblies = List.of(_assemblies)..addAll(assemblies);
        _isAssemblyLoading = false;
        for (var i = 0; i < _assemblies.length; i++) {
          if (_voter?.assemblyId == _assemblies[i].id) {
            _assembly = _assemblies[i];
            break;
          }
        }
      });
    } catch (e) {
      setState(() {
        _isAssemblyLoading = false;
      });
      _updateSuccessMessage(e);
    }
  }

  void getLocalbodies(districtId) async {
    setState(() {
      _isLocalbodyLoading = true;
      _localbodies.clear();
      _localbodies.add(Constant.localbody);
      _localbody = _localbodies[0];
    });
    try {
      List<Localbody> localbodies =
          await _remoteService.getLocalbodies(districtId);
      setState(() {
        _localbodies = List.of(_localbodies)..addAll(localbodies);
        _isLocalbodyLoading = false;
        for (var i = 0; i < _localbodies.length; i++) {
          if (_voter?.localbodyId == _localbodies[i].id) {
            _localbody = _localbodies[i];
            getWards(_localbody?.id ?? 0);
            break;
          }
        }
      });
    } catch (e) {
      setState(() {
        _isLocalbodyLoading = false;
      });
      _updateSuccessMessage(e);
    }
  }

  void getWards(int localbodyId) async {
    setState(() {
      _isWardLoading = true;
      _wards.clear();
      _wards.add(Constant.ward);
      _ward = _wards[0];
    });
    try {
      List<Ward> wards = await _remoteService.getWards(localbodyId);
      setState(() {
        _wards = List.of(_wards)..addAll(wards);
        _isWardLoading = false;
        for (var i = 0; i < _wards.length; i++) {
          if (_voter?.wardId == _wards[i].id) {
            _ward = _wards[i];
            break;
          }
        }
      });
    } catch (e) {
      setState(() {
        _isWardLoading = false;
      });
      _updateSuccessMessage(e);
    }
  }

  Future<void> _refresh() async {}

  Future<void> getParties() async {
    try {
      List<Party> parties = await _remoteService.getParties();
      setState(() {
        _parties = parties;
      });
      getChartVoterLength();
    } catch (e) {
      _updateSuccessMessage(e);
    }
  }

  Future<void> getChartVoterLength() async {
    try {
      int totalVoters = await _remoteService.getChartsLength();
      setState(() {
        _totalVoters = totalVoters;
      });
      getChartData();
    } catch (e) {
      _updateSuccessMessage(e);
    }
  }

  Future<void> getChartData() async {
    try {
      List<ChartModel> chartModels = await _remoteService.getCharts();
      setState(() {
        _charts = chartModels;
        for (var i = 0; i < _charts.length; i++) {
          if (_charts[i].partyId[0].id == 1) {
            _ntk += 1;
          }
        }
        _count = _totalVoters - _ntk;
        _pipDataSource = [
          _PieData('நாம் தமிழர் கட்சி ($_ntk)', _ntk, '$_ntk'),
          _PieData('பிற கட்சிகள் ($_count)', _count, '$_count')
        ];
      });
    } catch (e) {
      _updateSuccessMessage(e);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _updateSuccessMessage(var e) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
        duration: Duration(seconds: Constant.limit, milliseconds: 0)));
  }

  @override
  bool get wantKeepAlive => true;
}

class _PieData {
  _PieData(this.xData, this.yData, this.text);

  final String xData;
  final num yData;
  final String text;
}
