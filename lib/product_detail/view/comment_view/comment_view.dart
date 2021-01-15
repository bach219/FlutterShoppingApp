import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttercommerce/product_detail/bloc/comment_bloc/comment_bloc.dart';
import 'package:formz/formz.dart';

class Comment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<CommentBloc, CommentState>(
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          // Scaffold.of(context).hideCurrentSnackBar();
          showDialog<void>(context: context, builder: (_) => SuccessDialog());
        }
        // if (state.status.isSubmissionInProgress) {
        //   Scaffold.of(context)
        //     ..hideCurrentSnackBar()
        //     ..showSnackBar(
        //       const SnackBar(content: Text('Submitting...')),
        //     );
        // }
      },
      child: AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0))),
        content: Container(
          height: MediaQuery.of(context).size.height / 2.5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _CommentInput(),
              _CommentButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class SuccessDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.0))),
      content: Container(
        height: MediaQuery.of(context).size.height / 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.check_circle_outline,
              size: 96,
              color: Color(0xFF10CA88),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                "Bình luận thành công",
                style: TextStyle(fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                "Cửa hàng sẽ sớm phản hồi lại bạn!",
                style: TextStyle(fontSize: 16),
              ),
            ),
            FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0),
              ),
              color: Color(0xFFDBCC8F),
              onPressed: () => {},
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: 15.0,
                  horizontal: 10.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          Navigator.of(context, rootNavigator: true).pop();
                        },
                        child: Text(
                          "OK!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CommentInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentBloc, CommentState>(
        buildWhen: (previous, current) => previous.comment != current.comment,
        builder: (context, state) {
          return Container(
            child: Padding(
              padding:
                  const EdgeInsets.only(bottom: 5.0, left: 10.0, right: 10.0),
              child: TextField(
                key: const Key('commentForm_commentInput_textField'),
                maxLines: 7,
                onChanged: (comment) =>
                    context.read<CommentBloc>().add(CommentChanged(comment)),
                textAlign: TextAlign.center,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  fillColor: Theme.of(context).dividerColor,
                  icon: const Icon(Icons.comment),
                  hintStyle: Theme.of(context).textTheme.display2,
                  labelText: "Phần bình luận",
                  errorText:
                      state.comment.invalid ? 'Bình luận bị bỏ trống' : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  filled: true,
                  contentPadding: EdgeInsets.all(10),
                  // prefixIcon: Icon(
                  //   Icons.comment,
                  //   color: Colors.black,
                  // ),
                ),
              ),
            ),
          );
        });
  }
}

class _CommentButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentBloc, CommentState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          return state.status.isSubmissionInProgress
              ? const CircularProgressIndicator(
                  backgroundColor: Color(0xFFDBCC8F),
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                )
              : Container(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 5.0, left: 24.0, right: 24.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      child: new Row(
                        children: <Widget>[
                          new Expanded(
                            child: new FlatButton(
                              shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0),
                              ),
                              color: Theme.of(context).primaryColor,
                              onPressed: state.status.isValidated
                                  ? () {
                                      context
                                          .read<CommentBloc>()
                                          .add(const CommentSubmitted());
                                    }
                                  : null,
                              child: new Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 15.0,
                                  horizontal: 10.0,
                                ),
                                child: new Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    new Expanded(
                                      child: Text(
                                        "Bình luận",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
        });
  }
}
