import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class ListOfIndications extends StatelessWidget {
  const ListOfIndications({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(8),
      children: <Widget>[

        ListTile( title: Text("Indication 1 : ",style: GoogleFonts.poppins(textStyle: TextStyle( fontSize: 16, fontWeight: FontWeight.w600,)),),
          subtitle: Text("Restez calme et évacuez le bâtiment le plus rapidement et en toute sécurité possible."),
          leading: FaIcon(FontAwesomeIcons.one,color: Theme.of(context).accentColor),),
        ListTile( title: Text("Indication 2 :",style: GoogleFonts.poppins(textStyle: TextStyle( fontSize: 16, fontWeight: FontWeight.w600,))),
            subtitle: Text("Si vous êtes bloqué, fermez toutes les portes et les fenêtres pour empêcher la propagation du danger."),
          leading: FaIcon(FontAwesomeIcons.two,color: Theme.of(context).accentColor),),        ListTile( title: Text("Indication 3 :",style: GoogleFonts.poppins(textStyle: TextStyle( fontSize: 16, fontWeight: FontWeight.w600,)),),
            subtitle: Text("Utilisez les escaliers plutôt que les ascenseurs pour évacuer les étages supérieurs."),  leading: FaIcon(FontAwesomeIcons.three,color: Theme.of(context).accentColor),),
        ListTile( title: Text("Indication 4 :",style: GoogleFonts.poppins(textStyle: TextStyle( fontSize: 16, fontWeight: FontWeight.w600,))),
            subtitle: Text("Si vous rencontrez de la fumée, restez bas pour éviter de respirer des fumées nocives."),  leading: FaIcon(FontAwesomeIcons.four,color: Theme.of(context).accentColor),),
        ListTile( title: Text("Indication 5 :",style: GoogleFonts.poppins(textStyle: TextStyle( fontSize: 16, fontWeight: FontWeight.w600,))),
            subtitle: Text("Si possible, prenez un téléphone portable avec vous pour appeler les secours ou envoyer un message à vos proches."),  leading: FaIcon(FontAwesomeIcons.five,color: Theme.of(context).accentColor),),
        ListTile( title: Text("Indication 6 :",style: GoogleFonts.poppins(textStyle: TextStyle( fontSize: 16, fontWeight: FontWeight.w600,))),
            subtitle: Text("Si vous êtes à l'extérieur, éloignez-vous du bâtiment et évitez les zones à haut risque comme les lignes électriques et les conduites de gaz."),  leading: FaIcon(FontAwesomeIcons.six,color: Theme.of(context).accentColor),),
        ListTile( title: Text("Indication 7 :",style: GoogleFonts.poppins(textStyle: TextStyle( fontSize: 16, fontWeight: FontWeight.w600,))),
            subtitle: Text("Si vous êtes blessé, demandez de l'aide immédiatement."),  leading: FaIcon(FontAwesomeIcons.seven,color: Theme.of(context).accentColor),),
        ListTile( title: Text("Indication 8 :",style: GoogleFonts.poppins(textStyle: TextStyle( fontSize: 16, fontWeight: FontWeight.w600,))),
            subtitle: Text("Restez informé de la situation en écoutant les médias locaux et en suivant les instructions des autorités compétentes."),  leading: FaIcon(FontAwesomeIcons.eight,color: Theme.of(context).accentColor),),


      ],
    );
  }
}
