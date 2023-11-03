import 'package:flutter/material.dart';
import 'package:parking_project/presentation/pages/requests_page/components/incoming_outgoing_requests_toggle.dart';
import 'package:parking_project/presentation/pages/requests_page/components/requests_list.dart';
import 'package:parking_project/presentation/pages/requests_page/request_page_bloc/requests_page_bloc.dart';

import '../../../../data/models/request_dto.dart';

class SegmentedButtonRequestSection extends StatefulWidget {
  final bool isLoading;
  final List<RequestDto> incomingRequests;
  final List<RequestDto> outgoingRequests;

  const SegmentedButtonRequestSection(
      {super.key,
      required this.isLoading,
      required this.incomingRequests,
      required this.outgoingRequests});

  @override
  State<SegmentedButtonRequestSection> createState() =>
      _SegmentedButtonRequestSectionState();
}

class _SegmentedButtonRequestSectionState
    extends State<SegmentedButtonRequestSection> {
  Set<SelectedRequestType> _selectedRequestType = {
    SelectedRequestType.Incoming
  };

  void _changeRequestType(Set<SelectedRequestType> requestType) {
    setState(() {
      _selectedRequestType = requestType;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 500),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                "Запросы на обмен",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(
                height: 32,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: IncomingOutgoingRequestsToggle(
                  selectedRequests: _selectedRequestType,
                  onSelected: (Set<SelectedRequestType> selected) {
                    _changeRequestType(selected);
                  },
                ),
              ),
              SizedBox(
                height: 32,
              ),
              Expanded(
                  child: RequestsSection(
                    isLoading: widget.isLoading,
                requestsList:
                    _selectedRequestType.contains(SelectedRequestType.Incoming)
                        ? widget.incomingRequests
                        : widget.outgoingRequests,
              ))
            ],
          ),
        ),
      ),
    );
  }
}
