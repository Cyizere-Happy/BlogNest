import org.example.blognest.model.Gender;
import org.example.blognest.model.Person;
import org.junit.Assert;
import org.junit.Test;

public class PersonTest {

    @Test
    public void getGender() {
        Person p = new Person(1, "Mike", "Mugisha", Gender.MALE , 18);
        Assert.assertTrue(p.getGender() == Gender.MALE);
        Assert.assertFalse(p.getGender() == Gender.FEMALE);
    }

}