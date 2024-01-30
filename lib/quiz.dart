import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizflutter/home_page.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  int currentQuestionIndex = 0; // indice da pergunta atual
  String? selectedAnswer;
  bool? isCorrect;
  bool quizConcluido = false;
  int questoesAcertadas =0;
  final List<Map<String, dynamic>> questions = [
    {
      'question': 'Qual desses animais é conhecido por sua impressionante capacidade de mudar de cor?',
      'answers' : ['Golfinho', 'Polvo','Tubarão','Baleia'],
      'correctAnswer': 'Polvo'
    },
     {
      'question':
       'Qual desses animail marinho é famoso por sua carapaça dura e longa  vida?',
      'answers' : ['Estrela do Mar', 'Carangueijo','Tartaruga Marinha','Baleia Azul'],
      'correctAnswer': 'Tartaruga Marinha'
    },
    //add mais perguntas aqui
  ];


  void nextQuestion(){
    if(currentQuestionIndex < questions.length - 1){
      setState(() {
        currentQuestionIndex++;
      });
    }else{
      setState(() {
        quizConcluido=true;
        Future.delayed(Duration(seconds: 5), (){
          Navigator.of(context).push(MaterialPageRoute(builder: (_) => new HomePage()));
        });
      });
      }
  }

  void handleAnswer(String answers){
    setState(() {
      selectedAnswer = answers;
      isCorrect = answers == questions[currentQuestionIndex]['correctAnswer'];
    });

    Future.delayed(Duration(seconds:2), (){
      nextQuestion();
    });
  }

 @override
  Widget build(BuildContext context) {
    if(quizConcluido){
        return Scaffold(
              appBar: AppBar(
                title: Text('Quiz finalizado', style: GoogleFonts.nunitoSans(fontSize: 18, fontWeight: FontWeight.bold),),
                centerTitle: true,
              ),
              body: ListView(
                children: [
                    SizedBox(
                      height: 800,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Card(
                          color: Colors.blueGrey[100],
                          elevation: 10,
                          child: Text(
                            'Quiz Finalizado. \nParabéns!!! \n Você acertou $questoesAcertadas questões!', 
                            style: GoogleFonts.arimo(fontSize: 60, fontWeight: FontWeight.bold),
                          ),
                                    ),
                        ],
                      ),
                    ),
                  
                ],
              ),
            );
    }


    var currentquestion = questions[currentQuestionIndex];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[50],
        title: Text('Quiz marítimo', style: GoogleFonts.roboto(fontWeight: FontWeight.bold),)
        ),
        body: Column(
          children: [
          Container(
            padding: const EdgeInsets.all(18),
            color: Colors.deepPurple[50],
            width: double.infinity,
            height: 400,
            child: Center(
              child: Text(currentquestion['question'],
              style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 18),),
            ),
          ),
          Wrap(
            children: currentquestion['answers'].map<Widget>((resposta){
              bool isSelected = selectedAnswer == resposta;
              Color? buttonColor;
              if(isSelected){
                buttonColor= isCorrect! ? Colors.green : Colors.red;
                isCorrect! ? questoesAcertadas++ : null;
              }

              return meuBtn(resposta, () => handleAnswer(resposta), buttonColor);
            }).toList(),
          )
        ],
        ),
    );
  }
 }




Widget meuBtn(String resposta, VoidCallback onPressed, Color? color) => 
  Container(
    margin: const EdgeInsets.all(16),
    width: 160,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
      ),
      child: Text(resposta),
    ),
  );