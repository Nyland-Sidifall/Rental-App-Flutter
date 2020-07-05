
import 'package:flutterrentalapp/Models/messaging_objects.dart';
import 'package:flutterrentalapp/Models/posting_objects.dart';
import 'package:flutterrentalapp/Models/review_objects.dart';
import 'package:flutterrentalapp/Models/user_objects.dart';

class PracticeData{

  //User Data
  static List<User> users = [];
  static List<Posting> postings= [] ;

  static populateFields(){
    User user1 = User(
      firstName: "Fake",
      lastName: "Name",
      email: "fakeemail1@fakehost.com",
      bio: "Me go go travel bro!",
      city: "Nunya",
      country: "Biz",
    );
    user1.isHost = true;
    User user2 = User(
      firstName: "Faker",
      lastName: "Namer",
      email: "evenfakeremail1@fakehost.com",
      bio: "Traveling is cool I think.",
      city: "Topeca",
      country: "Idaho",
    );

    users.add(user1);
    users.add(user2);

    Review review = Review();
    review.createReview(
        user2.createContactFromUser(),
        "He parents must be mushrooms, because he\'s a fun guy!",
        4.5,
        DateTime.now(),
    );

    user1.reviews.add(review);

    Conversation conversation = Conversation();
    conversation.createConversation(user2.createContactFromUser(), []);

    Message message1 = Message();
    message1.createMessage(
        user1.createContactFromUser(),
        "What\'s Gucci my guy?",
        DateTime.now(),
    );

    Message message2 = Message();
    message2.createMessage(
      user2.createContactFromUser(),
      "Nun much bruh?",
      DateTime.now(),
    );


    conversation.messages.add(message1);
    conversation.messages.add(message2);

    user1.conversations.add(conversation);

    Posting posting1 = Posting(
      name: "SomePlace",
      type: "Apartment",
      price: 800,
      description: "This place is great for the kids from 10 and up.",
      address: "1123 FakeStreet Dr.",
      city: "FakeCity",
      country: "FakeCountry",
      host: user1.createContactFromUser(),
    );

//    posting1.setImages(["assets/images/apartment.jpg","assets/images/defaultAvatar.png"]);
    posting1.amenities = ['washer','dryer','iron','coffee machine'];
    posting1.beds = {
      'small':0,
      'medium':2,
      'large':2,
    };
    posting1.bathrooms = {
      'full':2,
      'half':1,
    };

    Posting posting2 = Posting(
      name: "SomeOtherPlace",
      type: "Condo",
      price: 700,
      description: "Great for a single.",
      address: "3211 EvenFakerStreet Dr.",
      city: "EvenFakeCity",
      country: "EvenFakerCountry",
      host: user2.createContactFromUser(),
    );

//    posting2.setImages(["assets/images/apartment.jpg","assets/images/defaultAvatar.png","assets/images/apartment.jpg"]);
    posting2.amenities = ['dishwasher','cabel','wifi'];
    posting2.beds = {
      'small':1,
      'medium':0,
      'large':1,
    };
    posting2.bathrooms = {
      'full':1,
      'half':1,
    };
    postings.add(posting1);
    postings.add(posting2);

    Booking booking1 = Booking();
    booking1.createBooking(
      posting2,
      user1.createContactFromUser(),
      [DateTime(2020,06,26),DateTime(2020,06,27),DateTime(2020,06,28),],
    );
    posting2.bookings.add(booking1);

    Booking booking2 = Booking();
    booking2.createBooking(
      posting2,
      user1.createContactFromUser(),
      [DateTime(2020,07,21),DateTime(2020,07,22),],
    );
    posting2.bookings.add(booking2);

    Review postingReview = Review();
    postingReview.createReview(
      user2.createContactFromUser(),
      "Pretty decent place, not that big tho",
        3.5,
      DateTime(2019,08,08),
    );
    posting1.reviews.add(postingReview);

    print("from data, booking 1 ${booking1.dates.toString()}");
    print("from data, booking 2 ${booking2.dates.toString()}");


    user1.bookings.add(booking1);
    user1.bookings.add(booking2);
    user1.myPostings.add(posting1);
    user2.myPostings.add(posting2);
    
    user1.savedPostings.add(posting2);
  }
}