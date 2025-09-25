import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text('Paramètres et activité',style: TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(

                decoration: InputDecoration(
                  hintText: 'Rechercher',
                  hintStyle: const TextStyle(color: Colors.white),
                  prefixIcon: const Icon(Icons.search, color: Colors.white),
                  border: OutlineInputBorder(

                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[800],
                ),
              ),
            ),
            Builder(
              builder: (context) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child:
                    Text('Votre compte',style: TextStyle(color: Colors.white,fontSize: 15),),

                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Icon(FontAwesomeIcons.meta,color: Colors.grey,size: 16),
                    )
                  ],
                );
              }
            ),
            _buildSettingsItem(

              icon: Icons.person_outline,
              text: 'Espace Comptes',
              subtitle:
              'Mot de passe, sécurité, informations personnelles, préférences publicitaires', // Sous-titre
              onTap: () {

              },
            ),
            Divider(
              color: Colors.grey[800],
              thickness: 6,
              height: 6,
            ),
            _buildSectionTitle('Comment vous utilisez Instagram'),
            _buildSettingsItem(
              icon: Icons.bookmark_border,
              text: 'Enregistrements',
              onTap: () {},
            ),
            _buildSettingsItem(
              icon: Icons.history,
              text: 'Archive',
              onTap: () {},
            ),
            _buildSettingsItem(
              icon: Icons.bar_chart, // Icône ajustée
              text: 'Votre activité',
              onTap: () {},
            ),
            _buildSettingsItem(
              icon: Icons.notifications_none,
              text: 'Notifications',
              onTap: () {},
            ),
            _buildSettingsItem(
              icon: Icons.timer,
              text: 'Gestion du temps',
              onTap: () {},
            ),
            Divider(
              color: Colors.grey[800],
              thickness: 6,
              height: 6,
            ),
            _buildSectionTitle('Pour les professionnels'),
            _buildSettingsItem(
              icon: Icons.insert_chart_outlined,
              text: 'Statistiques',
              onTap: () {},
            ),
            _buildSettingsItem(
              icon: Icons.build_outlined, // Icône pour outils de créateur
              text: 'Outils et contrôles du Creator',
              onTap: () {},
            ),
            _buildSettingsItem(
              icon: Icons.verified_outlined,
              text: 'Montrer que votre profil est vérifié',
              trailingText: 'Pas abonné(e)', // Texte à droite
              onTap: () {},
            ),
            Divider(
              color: Colors.grey[800],
              thickness: 6,
              height: 6,
            ),
            _buildSectionTitle('Qui peut voir votre contenu'),
            _buildSettingsItem(
              icon: Icons.lock_outline,
              text: 'Confidentialité du compte',
              trailingText: 'Public',
              onTap: () {},
            ),
            _buildSettingsItem(
              icon: Icons.star_border,
              text: 'Ami(e)s proches',
              trailingText: '14',
              onTap: () {},
            ),
            _buildSettingsItem(
              icon: Icons.compare_arrows, // Icône pour le crosspostage
              text: 'Crosspostage',
              onTap: () {},
            ),
            _buildSettingsItem(
              icon: Icons.block,
              text: 'Bloqué',
              trailingText: '2',
              onTap: () {},
            ),
            _buildSettingsItem(
              icon: Icons.visibility_off_outlined,
              text: 'Masquer la story et les directs',
              onTap: () {},
            ),
            Divider(
              color: Colors.grey[800],
              thickness: 6,
              height: 6,
            ),
            _buildSectionTitle('Moyens d\'interagir avec vous'),
            _buildSettingsItem(
              icon: Icons.message_outlined,
              text: 'Messages et réponses aux stories',
              onTap: () {},
            ),
            _buildSettingsItem(
              icon: Icons.alternate_email, // Icône pour les tags
              text: 'Tags et mentions',
              onTap: () {},
            ),
            _buildSettingsItem(
              icon: Icons.comment_outlined,
              text: 'Commentaires',
              onTap: () {},
            ),
            _buildSectionTitle('Partage et réutilisation'),
            _buildSettingsItem(
              icon: Icons.share_outlined,
              text: 'Partage et réutilisation',
              onTap: () {},
            ),
            _buildSettingsItem(
              icon: Icons.face_retouching_natural, // Icône pour avatars
              text: 'Interactions avec les avatars',
              onTap: () {},
            ),
            _buildSettingsItem(
              icon: Icons.person_off_outlined, // Icône pour comptes restreints
              text: 'Comptes restreints',
              trailingText: '0',
              onTap: () {},
            ),
            _buildSettingsItem(
              icon: Icons.warning_amber_outlined, // Icône pour limiter les interactions
              text: 'Limiter les interactions',
              trailingText: 'Désactivé',
              onTap: () {},
            ),
            _buildSettingsItem(
              icon: Icons.text_fields, // Icône pour mots masqués
              text: 'Mots masqués',
              onTap: () {},
            ),
            _buildSettingsItem(
              icon: Icons.person_add_alt_1_outlined,
              text: 'Suivre et inviter des ami(e)s',
              onTap: () {},
            ),
            Divider(
              color: Colors.grey[800],
              thickness: 6,
              height: 6,
            ),
            _buildSectionTitle('Ce qui est visible'),
            _buildSettingsItem(
              icon: Icons.star_border,
              text: 'Favoris',
              trailingText: '2',
              onTap: () {},
            ),
            _buildSettingsItem(
              icon: Icons.volume_off_outlined,
              text: 'Comptes mis en sourdine',
              trailingText: '0',
              onTap: () {},
            ),
            _buildSettingsItem(
              icon: Icons.content_paste, // Icône pour préférences de contenu
              text: 'Préférences de contenu',
              onTap: () {},
            ),
            _buildSettingsItem(
              icon: Icons.favorite_border,
              text: 'Nombre de J\'aime et de partages',
              onTap: () {},
            ),
            _buildSettingsItem(
              icon: Icons.subscriptions_outlined,
              text: 'Abonnements',
              onTap: () {},
            ),
            Divider(
              color: Colors.grey[800],
              thickness: 6,
              height: 6,
            ),
            _buildSectionTitle('Votre application et vos contenus multimédias'),
            _buildSettingsItem(
              icon: Icons.phone_android,
              text: 'Autorisations de l\'appareil',
              onTap: () {},
            ),
            _buildSettingsItem(
              icon: Icons.download_outlined,
              text: 'Archivage et téléchargements',
              onTap: () {},
            ),
            _buildSettingsItem(
              icon: Icons.accessibility_new,
              text: 'Accessibilité',
              onTap: () {},
            ),
            _buildSettingsItem(
              icon: Icons.language,
              text: 'Langue et traduction',
              onTap: () {},
            ),
            _buildSettingsItem(
              icon: Icons.signal_cellular_alt, // Icône pour utilisation des données
              text: 'Utilisation des données et qualité des contenus multimédias',
              onTap: () {},
            ),
            _buildSettingsItem(
              icon: Icons.laptop_mac_outlined, // Icône pour autorisations web
              text: 'Autorisations pour le site Web et l\'application',
              onTap: () {},
            ),
            _buildSettingsItem(
              icon: Icons.science_outlined, // Icône pour accès anticipé
              text: 'Accès anticipé aux fonctionnalités',
              onTap: () {},
            ),
            Divider(
              color: Colors.grey[800],
              thickness: 6,
              height: 6,
            ),
            _buildSectionTitle('Pour les familles'),
            _buildSettingsItem(
              icon: Icons.family_restroom_outlined,
              text: 'Centre familial',
              onTap: () {},
            ),
            Divider(
              color: Colors.grey[800],
              thickness: 6,
              height: 6,
            ),
            _buildSectionTitle('Vos commandes et vos collectes de dons'),
            _buildSettingsItem(
              icon: Icons.payment_outlined,
              text: 'Commandes et paiements',
              onTap: () {},
            ),
            Divider(
              color: Colors.grey[800],
              thickness: 6,
              height: 6,
            ),
            _buildSectionTitle('Plus d\'infos et d\'assistance'),
            _buildSettingsItem(
              icon: Icons.help_outline,
              text: 'Aide',
              onTap: () {},
            ),
            _buildSettingsItem(
              icon: Icons.security_outlined,
              text: 'Centre de confidentialité',
              onTap: () {},
            ),
            _buildSettingsItem(
              icon: Icons.account_circle_outlined,
              text: 'Statut du compte',
              onTap: () {},
            ),
            _buildSettingsItem(
              icon: Icons.info_outline,
              text: 'À propos',
              onTap: () {},
            ),
            Divider(
              color: Colors.grey[800],
              thickness: 6,
              height: 6,
            ),
            _buildSectionTitle('Autres applications Meta'),
            _buildSettingsItem(
              icon: Icons.call,
              text: 'WhatsApp',
              subtitle: 'Envoyez des messages privés aux ami(e)s et à la famille',
              onTap: () {},
            ),
            _buildSettingsItem(
              icon: Icons.edit_outlined,
              text: 'Edits',
              subtitle: 'Créez des vidéos avec des outils d\'édition polyvalents',
              trailingWidget: Container(
                // Un petit cercle bleu comme dans l'image
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              onTap: () {},
            ),
            _buildSettingsItem(
              icon: Icons.forum_outlined,
              text: 'Threads',
              subtitle: 'Partagez des idées et rejoignez des conversations',
              onTap: () {},
            ),
            _buildSettingsItem(
              icon: Icons.facebook,
              text: 'Facebook',
              subtitle: 'Découvrez des choses que vous aimez',
              onTap: () {},
            ),
            _buildSettingsItem(
              icon: Icons.message_outlined,
              text: 'Messenger',
              subtitle: 'Discutez et partagez du contenu avec vos ami(e)s en toute simplicité',
              onTap: () {},
            ),
            Divider(
              color: Colors.grey[800],
              thickness: 6,
              height: 6,
            ),
            _buildSectionTitle('Connexion'),
            _buildTextButton('Ajouter un compte', Colors.blue, () {}), // Bouton texte bleu
            _buildTextButton('Se déconnecter', Colors.red, () {}), // Bouton texte rouge
            _buildTextButton('Déconnecter tous les comptes', Colors.red, () {}), // Bouton texte rouge
            const SizedBox(height: 20), // Ajoute un espace en bas
          ],
        ),
      ),
    );
  }
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildSettingsItem({
    required IconData icon,
    required String text,
    String? subtitle,
    String? trailingText,
    Widget? trailingWidget,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(

          children: [
            Icon(icon, color: Colors.white, size: 24),
            const SizedBox(width: 16),
            Expanded(
              child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  if (subtitle != null)
                    Text(
                      subtitle,
                      style: const TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                ],
              ),
            ),
            if (trailingText != null)
              Text(
                trailingText,
                style: const TextStyle(color: Colors.grey, fontSize: 14),
              ),
            if (trailingWidget != null)
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: trailingWidget,
              ),
            const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
          ],
        ),
      ),
    );
  }


  Widget _buildTextButton(String text, Color color, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            text,
            style: TextStyle(color: color, fontSize: 16),
          ),
        ),
      ),
    );
  }
}